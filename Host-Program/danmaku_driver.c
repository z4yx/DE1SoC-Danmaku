#include "danmaku_driver.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <pthread.h>

#include "constants.h"

#define REG_OFF32(base, number) ((volatile uint32_t*)((uintptr_t)(base)+4*(number)))

typedef struct{
    int fd_devmem;
    int fd_udmabuf0;
    int fd_udmabuf1;
    size_t sz_udmabuf0;
    uintptr_t uaddr_perph_base;
    uintptr_t uaddr_fb;
    uintptr_t paddr_fb;
    size_t sz_dyn_area;
    uintptr_t uaddr_dyn_area;
    uintptr_t paddr_dyn_area;
    size_t sz_allocated;
}driver_ctx;

void start_udmabuf(void)
{
    system("rmmod udmabuf");
    system("modprobe udmabuf udmabuf0=16777216 udmabuf1=67108864");
    system("echo 6 >/sys/class/udmabuf/udmabuf1/sync_mode");
}

DANMAKU_HW_HANDLE DanmakuHW_Open(void)
{
    char attr[1024]={0};
    unsigned int  fd, tmp, udmabuf0_size, udmabuf0_phys;
    unsigned int  udmabuf1_size, udmabuf1_phys;
    if ((fd  = open("/sys/bus/platform/devices/ff210000.sysid/sysid/id", O_RDONLY)) != -1) {
        read(fd, attr, 1024);
        close(fd);
        tmp = strtoul(attr, NULL, 0);
        if(tmp != QSYS_SYSTEMID){
            fprintf(stderr, "Unexpected System ID: %p\n", tmp);
            return NULL;
        }
    }else {
        fprintf(stderr, "Failed to read System ID\n");
        return NULL;
    }
    if ((fd  = open("/sys/bus/platform/devices/ff210000.sysid/sysid/timestamp", O_RDONLY)) != -1) {
        if(read(fd, attr, 1024) > 0){
            printf("Hardware Build Time: %s\n", attr);
        }
        close(fd);
    }
    start_udmabuf();
    if ((fd  = open("/sys/class/udmabuf/udmabuf0/size", O_RDONLY)) != -1) {
        read(fd, attr, 1024);
        udmabuf0_size = strtoul(attr, NULL, 0);
        printf("udmabuf0 size: %p\n", udmabuf0_size);
        close(fd);
    }else{
        fprintf(stderr, "Failed to get udmabuf0 size\n");
        return NULL;
    }
    if ((fd  = open("/sys/class/udmabuf/udmabuf0/phys_addr", O_RDONLY)) != -1) {
        read(fd, attr, 1024);
        udmabuf0_phys = strtoul(attr, NULL, 0);
        printf("udmabuf0 phys_addr: %p\n", udmabuf0_phys);
        close(fd);
    }else{
        fprintf(stderr, "Failed to get udmabuf0 phys_addr\n");
        return NULL;
    }
    if ((fd  = open("/sys/class/udmabuf/udmabuf1/size", O_RDONLY)) != -1) {
        read(fd, attr, 1024);
        udmabuf1_size = strtoul(attr, NULL, 0);
        printf("udmabuf1 size: %p\n", udmabuf1_size);
        close(fd);
    }else{
        fprintf(stderr, "Failed to get udmabuf1 size\n");
        return NULL;
    }
    if ((fd  = open("/sys/class/udmabuf/udmabuf1/phys_addr", O_RDONLY)) != -1) {
        read(fd, attr, 1024);
        udmabuf1_phys = strtoul(attr, NULL, 0);
        printf("udmabuf1 phys_addr: %p\n", udmabuf1_phys);
        close(fd);
    }else{
        fprintf(stderr, "Failed to get udmabuf1 phys_addr\n");
        return NULL;
    }

    driver_ctx* ctx = (driver_ctx*)malloc(sizeof(driver_ctx));
    if(!ctx){
        perror("malloc");
        return NULL;
    }

    ctx->paddr_fb = udmabuf0_phys;
    ctx->sz_udmabuf0 = udmabuf0_size;
    ctx->paddr_dyn_area = udmabuf1_phys;
    ctx->sz_dyn_area = udmabuf1_size;
    if(FRAME_BUFFER_SIZE*NUM_FRAME_BUFFER > ctx->sz_udmabuf0){
        fprintf(stderr, "frame buffer exceeded udmabuf0 size\n");
        return NULL;
    }

    ctx->fd_devmem = open("/dev/mem", O_RDWR);
    if(!ctx->fd_devmem){
        perror("open /dev/mem");
        return NULL;
    }

    ctx->fd_udmabuf0 = open("/dev/udmabuf0", O_RDWR);
    if(!ctx->fd_udmabuf0){
        perror("open /dev/udmabuf0");
        goto fail_close_devmem;
    }

    ctx->fd_udmabuf1 = open("/dev/udmabuf1", O_RDWR);
    if(!ctx->fd_udmabuf1){
        perror("open /dev/udmabuf1");
        goto fail_close_udmabuf0;
    }

    ctx->uaddr_perph_base = 
        (uintptr_t)mmap(NULL, PERPH_ADDR_SPAN, PROT_READ | PROT_WRITE, 
                        MAP_SHARED, ctx->fd_devmem, PERPH_ADDR_BASE);
    if((int)ctx->uaddr_perph_base == -1){
        perror("mmap /dev/mem");
        goto fail_close_udmabuf1;
    }
    printf("uaddr_perph_base: %p\n", ctx->uaddr_perph_base);
    // *REG_OFF32(ctx->uaddr_perph_base+0x100, 1) = 0;
    // munmap((void*)ctx->uaddr_perph_base, PERPH_ADDR_SPAN);

    ctx->uaddr_fb = 
        (uintptr_t)mmap(NULL, ctx->sz_udmabuf0, PROT_READ | PROT_WRITE, 
                        MAP_SHARED, ctx->fd_udmabuf0, 0);
    if((int)ctx->uaddr_fb == -1){
        perror("mmap /dev/udmabuf0");
        goto fail_unmap_devmem;
    }
    printf("uaddr_fb: %p\n", ctx->uaddr_fb);
    ctx->uaddr_dyn_area = 
        (uintptr_t)mmap(NULL, ctx->sz_dyn_area, PROT_READ | PROT_WRITE, 
                        MAP_SHARED, ctx->fd_udmabuf1, 0);
    if((int)ctx->uaddr_dyn_area == -1){
        perror("mmap /dev/udmabuf1");
        goto fail_unmap_udmabuf0;
    }

    return (DANMAKU_HW_HANDLE)ctx;

fail_unmap_udmabuf0:
    munmap((void*)ctx->uaddr_fb, ctx->sz_udmabuf0);
fail_unmap_devmem:
    munmap((void*)ctx->uaddr_perph_base, PERPH_ADDR_SPAN);
fail_close_udmabuf1:
    close(ctx->fd_udmabuf1);
fail_close_udmabuf0:
    close(ctx->fd_udmabuf0);
fail_close_devmem:
    close(ctx->fd_devmem);
    return NULL;
}
void DanmakuHW_AllocRenderBuf(DANMAKU_HW_HANDLE h, uintptr_t *uaddr, uintptr_t *paddr, uint32_t length)
{
    driver_ctx* ctx = (driver_ctx*)h;
    if (ctx->sz_allocated + length > ctx->sz_dyn_area)
    {
        fprintf(stderr, "DanmakuHW_AllocRenderBuf: no enough space\n");
        exit(1);
    }
    *uaddr = ctx->uaddr_dyn_area + ctx->sz_allocated;
    *paddr = ctx->paddr_dyn_area + ctx->sz_allocated;
    ctx->sz_allocated += length;
}
void DanmakuHW_LoadEDID(DANMAKU_HW_HANDLE h, uint8_t* content, uint32_t length)
{
    driver_ctx* ctx = (driver_ctx*)h;
    assert(length <= 256);
    uintptr_t edid_slave = ctx->uaddr_perph_base+0x400;
    memcpy((void*)edid_slave, content, length);
}
uintptr_t DanmakuHW_GetFrameBuffer(DANMAKU_HW_HANDLE h, int buf_index)
{
    driver_ctx* ctx = (driver_ctx*)h;
    assert(buf_index >= 0 && buf_index < NUM_FRAME_BUFFER);
    return ctx->paddr_fb+buf_index*FRAME_BUFFER_SIZE;
}
void DanmakuHW_RenderStartDMA(DANMAKU_HW_HANDLE h,uintptr_t dst, uintptr_t src, uint32_t length)
{
    driver_ctx* ctx = (driver_ctx*)h;
    uintptr_t dma_csr = ctx->uaddr_perph_base+0x200;
    uintptr_t dma_desc = ctx->uaddr_perph_base+0x280;

    // printf("%s: %p<=%p %u\n",
    //     __func__, dst, src, length);
    // printf("DMA status: 0x%x\n",*REG_OFF32(dma_csr, 0));
    while(*REG_OFF32(dma_csr, 0) & 4){
        pthread_yield();
        // printf("render DMA full, 0x%x\n",*REG_OFF32(dma_csr, 0));

    }
    *REG_OFF32(dma_csr, 1) = 0; //Control
    *REG_OFF32(dma_desc, 0) = src; //Read Address
    *REG_OFF32(dma_desc, 1) = dst; //Write Address
    *REG_OFF32(dma_desc, 2) = length; //Length
    *REG_OFF32(dma_desc, 3) = 0x80000000; //Control
}
int DanmakuHW_RenderDMAIdle(DANMAKU_HW_HANDLE h)
{
    driver_ctx* ctx = (driver_ctx*)h;
    uintptr_t dma_csr = ctx->uaddr_perph_base+0x200;
    return ((*REG_OFF32(dma_csr, 0) & 3) == 2);
}
int DanmakuHW_FrameBufferTxmit(DANMAKU_HW_HANDLE h, int buf_index, uint32_t length)
{
    driver_ctx* ctx = (driver_ctx*)h;
    uintptr_t dma_csr = ctx->uaddr_perph_base+0x100;
    uintptr_t dma_desc = ctx->uaddr_perph_base+0x180;

    assert(buf_index >= 0 && buf_index < NUM_FRAME_BUFFER);
    assert(length <= FRAME_BUFFER_SIZE);
    assert((length & 0x7) == 0);

    // printf("%s: %p %u\n",
    //     __func__, DanmakuHW_GetFrameBuffer(h, buf_index), length);

    if(*REG_OFF32(dma_csr, 0) & 4){
        printf("Descriptor full\n");
        return -1;
    }

    *REG_OFF32(dma_csr, 1) = 0; //Control
    *REG_OFF32(dma_desc, 0) = DanmakuHW_GetFrameBuffer(h, buf_index); //Read Address
    *REG_OFF32(dma_desc, 2) = length; //Length
    *REG_OFF32(dma_desc, 3) = 0x80000000; //Control
    return 0;
}
int DanmakuHW_PendingTxmit(DANMAKU_HW_HANDLE h)
{
    driver_ctx* ctx = (driver_ctx*)h;
    uintptr_t dma_csr = ctx->uaddr_perph_base+0x100;
    return !(*REG_OFF32(dma_csr, 0) & 2);
}
int DanmakuHW_OverlayBusy(DANMAKU_HW_HANDLE h)
{
    driver_ctx* ctx = (driver_ctx*)h;
    uintptr_t dma_csr = ctx->uaddr_perph_base+0x100;
    return !(*REG_OFF32(dma_csr, 0) & 1);
}
void DanmakuHW_GetFrameSize(DANMAKU_HW_HANDLE h, unsigned int* height, unsigned int* width)
{
    driver_ctx* ctx = (driver_ctx*)h;
    uintptr_t sfr = ctx->uaddr_perph_base+0x300;
    uint32_t resolution = *REG_OFF32(sfr, 0);
    *height = resolution&0xffff;
    *width = (resolution>>16)&0xffff;
}
