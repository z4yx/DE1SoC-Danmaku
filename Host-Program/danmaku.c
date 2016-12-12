#include "danmaku_driver.h"

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <assert.h>
#include <stdbool.h>
#include <wchar.h>
#include <locale.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
#include <signal.h>

#include <ft2build.h>
#include FT_FREETYPE_H

#include "ring.h"
#include "constants.h"

#define MIN(x, y) ((x) < (y) ? (x) : (y))

pthread_mutex_t render_overlay_mutex;
pthread_cond_t  render_overlay_cv;

// global
FT_Library library;
FT_Face face;
FT_GlyphSlot slot;
DANMAKU_HW_HANDLE hDriver;

unsigned int edge; // edge in pixel for each character
unsigned int screen_width; // screen width in pixels
unsigned int screen_height; // screen height in pixels
unsigned int img_size;
int error; // last error code
volatile int render_running;

uint8_t *blank_screen;
uint32_t blank_screen_phy;

void intHandler(int dummy) {
    render_running = 0;
}

char PrintPixel(uint8_t n)
{
    switch (n) {
        case PXL_HSYNC:
            return 'H';
            break;
        case PXL_VSYNC:
            return 'V';
            break;
        case PXL_BLANK:
            return 'B';
            break;
        default:
            return '0' + n;
    }
}

void PrintBuf(uint8_t* buf)
{
    for (int i = 0; i < img_size; i++) {
        fprintf(stderr, "%c", PrintPixel(buf[i]));
    }
}

// fill map with blank color
void FillBlank(uint8_t map[][MAX_WIDTH * 2], int head, int len)
{
    assert(head + len <= MAX_WIDTH * 2);
    for (int i = 0; i < MAX_HEIGHT; i++) {
        for (int j = head; j < head + len; j++) {
            map[i][j] = PXL_BLANK;
        }
    }
}

// ==========================
// Font map interfaces.
bool InitFontMap()
{
    /* initialize library */
    error = FT_Init_FreeType(&library);
    if (error != 0)
    {
        fprintf(stderr, "initialize library: error %d\n", error);
        return false;
    }

    /* create face object */
    error = FT_New_Face(library, FONT_FILE_PATH, 0, &face);
    if (error != 0)
    {
        fprintf(stderr, "create face: error %d\n", error);
        return false;
    }

    /* set character size */
    error = FT_Set_Pixel_Sizes(face, edge, 0);
    if (error != 0)
    {
        fprintf(stderr, "set pixel size: error %d\n", error);
        return false;
    }

    slot = face->glyph;
    return true;
}

void ClearFontMap()
{
    FT_Done_Face(face);
    FT_Done_FreeType(library);
}

uint8_t map1[MAX_HEIGHT][MAX_WIDTH * 2];

void WriteFontMap(uint8_t map[][MAX_WIDTH * 2], int *text, int len)
{
    for (int i = 0; i < edge; i++) {
        for (int j = 0; j < edge * len; j++) {
            map[i][j] = PXL_BLANK;
            map1[i][j] = PXL_BLANK;
        }
    }

    int color = rand() % 8; // valid color: 0x0 ~ 0x7
    // printf("color selected: %d\n", color);
    int reverse = color ^ 7;
    for (int n = 0; n < len; n++) { // for each character
        // retrieve glyph index from character code in UTF-32
        FT_UInt glyph_index = FT_Get_Char_Index(face, text[n]);

        // load glyph image into the slot (erase previous one)
        error = FT_Load_Glyph(face, glyph_index, FT_LOAD_DEFAULT);
        if (error != 0)
        {
            fprintf(stderr, "load glyph: error %d\n", error);
            exit(1);
        }

        // convert to an anti-aliased bitmap
        error = FT_Render_Glyph(slot, FT_RENDER_MODE_NORMAL);
        if (error != 0)
        {
            fprintf(stderr, "render glyph: error %d\n", error);
            exit(1);
        }

        // obtain bit map
        FT_Bitmap *src = &slot->bitmap;

        int i, j, p, q;
        int dx = (edge - src->width) / 2;
        int dy = edge - src->rows;

        for (i = n * edge + dx, p = 0; p < src->width; i++, p++)
        {
            for (j = dy, q = 0; q < src->rows; j++, q++)
            {
                map1[j][i] = src->buffer[q * src->width + p] < 128 ? PXL_BLANK : color;
            }
        }
    }

    for (int i = 0; i < edge; i++) {
        for (int j = 0; j < len * edge; j++) {
            if (map1[i][j] == color) {
                map[i][j] = map1[i][j];
            } else if (
                (i + 1 < edge && map1[i + 1][j] == color) ||
                (j + 1 < len * edge && map1[i][j + 1] == color) ||
                (i - 1 > 0 && map1[i - 1][j] == color) ||
                (j - 1 > 0 && map1[i][j - 1] == color)
            ) {
                map[i][j] = reverse;
            }
        }
    }
}


// ==========================
// Sliding layer: slide from right to left.
typedef struct {
    int x, y; // left top point
    int width; // width
    int ppc; // pixels sliding per cycle
    bool enable;

    uint8_t (*map)[MAX_WIDTH * 2]; // pixel map (color for each pixel)
    uint8_t (*map_phy)[MAX_WIDTH * 2]; //physical address of pixel map
} sliding_layer_t;


void InitSliding(sliding_layer_t *s, int y)
{
    s->enable = false;
    s->y = y;
    DanmakuHW_AllocRenderBuf(hDriver, (uintptr_t*)&s->map, (uintptr_t*)&s->map_phy, MAX_HEIGHT*(MAX_WIDTH*2));
}

void SlidingNextCycle(sliding_layer_t *s)
{
    if (!s->enable) {
        return;
    }

    s->x -= s->ppc;
    if (s->x < -s->width) {
        s->enable = false;
    }
}

void SlidingSetDanmu(sliding_layer_t *s, int *text, int len)
{
    assert(!s->enable);

    WriteFontMap(s->map, text, len);
    s->enable = true;
    s->width = edge * len;
    s->x = screen_width;
    s->ppc = 1 + ((s->width + screen_width) / CYCLE_PER_DANMU);
}

// write one sliding layer
void SlidingWritePixels(uint8_t *dst, sliding_layer_t *s)
{
    if (!s->enable) {
        return;
    }

    int y = edge * s->y;
    uint32_t line_base = y * (screen_width + 2);
    int xfrom = s->x;
    int xto = s->x + s->width - 1;
    if(xfrom >= screen_width || xto < 0)
        return;
    if(xfrom < 0) xfrom = 0;
    if(xto >= screen_width) xto = screen_width-1;
    for (int i = 0; i < edge; i++) {
        uint32_t addr_xfrom = (line_base + xfrom);
        uint32_t addr_xto = (line_base + xto);
        DanmakuHW_RenderStartDMA(hDriver, &dst[addr_xfrom], &s->map_phy[i][0], addr_xto - addr_xfrom + 1);
        line_base += (screen_width + 2);
    }
}

void InitBlankScreen(void)
{
    uint32_t offset = 0;
    DanmakuHW_AllocRenderBuf(hDriver, (uintptr_t*)&blank_screen, &blank_screen_phy, img_size);
    for (int i = 0; i < screen_height; i++) {
        for (int j = 0; j < screen_width; j++) {
            blank_screen[offset++] = 0x10 | PXL_BLANK;
        }
        if (i < screen_height - 1) {
            blank_screen[offset++] = PXL_HSYNC;
            blank_screen[offset++] = PXL_HSYNC;
        }
    }
    // fill blank until reach img_size
    while (offset < img_size) {
        blank_screen[offset++] = 0x10 | PXL_BLANK;
    }

    // fill last two with VSYNC
    blank_screen[img_size - 1] = PXL_VSYNC;
    blank_screen[img_size - 2] = PXL_VSYNC;

}
// clear screen
void ClearScreen(uint8_t *dst)
{
    int blocks = 8;
    int blk_size = img_size/blocks;
    for (int i = blocks-1; i >= 0; --i)
    {
        DanmakuHW_RenderStartDMA(hDriver, dst+blk_size*i, blank_screen_phy+blk_size*i, blk_size);
        // usleep(100);
    }
    if(img_size%blocks!=0){
        DanmakuHW_RenderStartDMA(hDriver, dst+blk_size*blocks, blank_screen_phy+blk_size*blocks, img_size%blocks);
    }
}   


// ==========================
// Static layer: leaving on the first row on screen.
typedef struct {
    bool enable; // whether to enable static layer
    int counter;
    int valid_len; // actual length (in pixels) after setting text
    int y;

    uint8_t (*map)[MAX_WIDTH * 2]; // pixel map (color for each pixel)
    uint8_t (*map_phy)[MAX_WIDTH * 2]; //physical address of pixel map
} static_layer_t;

void InitStatic(static_layer_t *s, int y)
{
    s->y = y;
    s->enable = false;
    s->counter = 0;
    DanmakuHW_AllocRenderBuf(hDriver, (uintptr_t*)&s->map, (uintptr_t*)&s->map_phy, MAX_HEIGHT*(MAX_WIDTH*2));
    FillBlank(s->map, 0, MAX_WIDTH * 2);
}

bool StaticSetDanmu(static_layer_t *s, int *text, int len)
{
    if (s->enable) {
        return false;
    }

    // set
    WriteFontMap(s->map, text, len);
    s->valid_len = len * edge;
    s->enable = true;
    s->counter = 0;
    return true;
}

void ForceStaticSetDanmu(static_layer_t *s, int *text, int len)
{
    // set
    WriteFontMap(s->map, text, len);
    s->valid_len = len * edge;
    s->enable = true;
    s->counter = 0;
}

void StaticNextCycle(static_layer_t *s)
{
    if (s->enable) {
        ++s->counter;
        if (s->counter >= DURATION) {
            s->enable = false;
        }
    }
}

void StaticWritePixels(uint8_t *dst, static_layer_t *s)
{
    if (!s->enable) {
        return;
    }

    int y = edge * s->y;
    uint32_t line_base = y * (screen_width + 2);
    int xfrom;
    if (screen_width > s->valid_len) {
        xfrom = (screen_width - s->valid_len) / 2;
    } else {
        xfrom = 0;
    }
    int xto = xfrom + s->valid_len - 1;
    if(xfrom >= screen_width || xto < 0)
        return;
    if(xfrom < 0) xfrom = 0;
    if(xto >= screen_width) xto = screen_width-1;
    for (int i = 0; i < edge; i++) {
        uint32_t addr_xfrom = (line_base + xfrom);
        uint32_t addr_xto = (line_base + xto);
        DanmakuHW_RenderStartDMA(hDriver, &dst[addr_xfrom], &s->map_phy[i][0], addr_xto - addr_xfrom + 1);
        line_base += (screen_width + 2);
    }
}


// global layers
sliding_layer_t sliding_layers[SLIDING_LAYER_ROWS][SLIDING_LAYER_COLS];
static_layer_t static_layers[NUM_STATIC_LAYER];

// temporary buffer for stdin
wchar_t input_buf[MAX_TEXT_LEN];

bool buf_sliding_saved = false;
bool buf_static_saved = false;

// ==========================
// Main render process.
bool InsertSliding(wchar_t *buf_sliding)
{
    int len = wcslen(buf_sliding);
    for (int i = 0; i < SLIDING_LAYER_ROWS; i++) {
        for (int j = 0; j < SLIDING_LAYER_COLS; j++) {
            if (!sliding_layers[i][j].enable) {
                bool conflict = false;
                for (int k = 0; k < SLIDING_LAYER_COLS; k++) {
                    if (j != k && sliding_layers[i][k].enable && sliding_layers[i][k].x +
                        sliding_layers[i][k].width > screen_width) {
                        conflict = true;
                        break;
                    }
                }
                if (!conflict) {
                    SlidingSetDanmu(&sliding_layers[i][j], buf_sliding, len);
                    // printf("inserted into sliding layer (%d, %d), len=%d\n", i, j, len);
                    return true;
                }
            }
        }
    }

    return false;
}

bool InsertStatic(wchar_t *buf_static)
{
    int len = wcslen(buf_static);
    for (int i = 0; i < NUM_STATIC_LAYER; i++) {
        if (StaticSetDanmu(&static_layers[i], buf_static, len)) {
            // printf("inserted into static layer %d, len=%d\n", i, len);
            return true;
        }
    }

    int c = rand() % NUM_STATIC_LAYER;
    ForceStaticSetDanmu(&static_layers[c], buf_static, len);
    // printf("force inserted into static layer %d, len=%d\n", c, len);
    return true;
}

#define QUEEN_SIZE 4096

typedef struct {
    wchar_t str[QUEEN_SIZE][MAX_TEXT_LEN];
    int head;
    int tail;
} queen_t;

void InitQueen(queen_t *queen)
{
    queen->head = 0;
    queen->tail = 0;
}

bool Fetch(queen_t *queen, wchar_t *dst)
{
    if (queen->tail == queen->head) {
        return false;
    }

    wcscpy(dst, queen->str[queen->head]);
    return true;
}

void Pop(queen_t *queen)
{
    if (queen->tail - queen->head > 0) {
        queen->head++;
    }
}

void ClearQueen(queen_t *queen)
{
    int len = queen->tail - queen->head;
    for (int i = 0; i < len; i++) {
        wcscpy(queen->str[i], queen->str[queen->head + i]);
    }
    queen->head = 0;
    queen->tail = len;
}

void Push(queen_t *queen, wchar_t *src)
{
    if (queen->tail >= QUEEN_SIZE) {
        ClearQueen(queen);
    }
    wcscpy(queen->str[queen->tail++], src);
}

queen_t sliding_queen, static_queen;

void RenderOnce(uint8_t* buf)
{
    ClearScreen(buf);

    // save danum
    wchar_t *ret = fgetws(input_buf, MAX_TEXT_LEN, stdin);
    if (ret == NULL) {
        // printf("nothing fetched\n");
    } else {
        // printf("fetched:\n");
        // fputws(input_buf + 1, stdout);
        // int len = wcslen(input_buf + 1);
        // printf("codes:");
        // for (int i = 1; i < len; i++) {
            // printf("%d ", input_buf[i]);
        // }
        // printf("\n");
        // printf("type: %d\n", input_buf[0]);
        switch (input_buf[0]) {
            case '0':
                Push(&sliding_queen, input_buf + 1);
                break;
            case '1':
                Push(&static_queen, input_buf + 1);
                break;
            default:
                fprintf(stderr, "unknown type: %c\n", input_buf[0]);
                exit(1);
        }
    }

    // fetch danmu
    wchar_t tmp[MAX_TEXT_LEN];

    bool r = Fetch(&sliding_queen, tmp);
    if (r && InsertSliding(tmp)) {
        // printf("fetch from sliding queen:\n");
        // fputws(tmp, stdout);
        Pop(&sliding_queen);
    }

    r = Fetch(&static_queen, tmp);
    if (r && InsertStatic(tmp)) {
        // printf("fetch from static queen:\n");
        // fputws(tmp, stdout);
        Pop(&static_queen);
    }

    // apply a cycle
    for (int i = 0; i < SLIDING_LAYER_ROWS; i++) {
        for (int j = 0; j < SLIDING_LAYER_COLS; j++) {
            SlidingNextCycle(&sliding_layers[i][j]);
        }
    }
    for (int i = 0; i < NUM_STATIC_LAYER; i++) {
        StaticNextCycle(&static_layers[i]);
    }

    // render
    int offset = 0;
    for (int i = 0; i < SLIDING_LAYER_ROWS; i++) {
        for (int j = 0; j < SLIDING_LAYER_COLS; j++) {
            SlidingWritePixels(buf, &sliding_layers[i][j]);
            // usleep(1000);
        }
    }
    for (int i = 0; i < NUM_STATIC_LAYER; i++) {
        StaticWritePixels(buf, &static_layers[i]);
        // usleep(1000);
    }
}

void Render()
{
    int dbg = 0;

    pthread_mutex_lock(&render_overlay_mutex);
    for(int i=0; i<NUM_FRAME_BUFFER; i++)
        ClearScreen((void*)DanmakuHW_GetFrameBuffer(hDriver, i));
    while(!DanmakuHW_RenderDMAIdle(hDriver));
    render_running = 1;
    while (render_running) {
        int idx;
        while((idx = GetEmptyBuffer()) == -1);
#ifdef SIM_MODE
        uint8_t fb[MAX_IMG_SIZE];
#else
        void* fb = (void*)DanmakuHW_GetFrameBuffer(hDriver, idx);
#endif
        RenderOnce((uint8_t*)fb);
        while(!DanmakuHW_RenderDMAIdle(hDriver));
        printf("render %d done\n", idx);
        CommitBuffer();
    }
    render_running = 0;
    pthread_mutex_unlock(&render_overlay_mutex);
}

void *Thread4Overlay(void *t) 
{
    int dbg = 0;
    int repeat = 0;
    int idx;

    while(!render_running);
    printf("Thread4Overlay started\n");

    while((idx = GetFilledBuffer()) == -1);
    for(;render_running;){
        DanmakuHW_FrameBufferTxmit(hDriver, idx, img_size);
        printf("transmitting %d\n", idx);

        while(DanmakuHW_PendingTxmit(hDriver));

        if((++repeat >= 2) && RingSize() > 2){
            //render done, switching buffer

            while(DanmakuHW_OverlayBusy(hDriver));
            ReleaseBuffer();

            idx = GetFilledBuffer();

            repeat = 0;
        }
    }
    pthread_exit(NULL);
}

void SubMain()
{
    pthread_attr_t attr;
    pthread_t overlay_thread;

    DanmakuHW_GetFrameSize(hDriver, &screen_height, &screen_width);
    printf("screen: %d * %d\n", screen_width, screen_height);

    if (screen_width < 100 || screen_height < 100) {
        printf("invalid size detected\n");
        usleep(1000);
        return;
    }

    img_size = (((screen_width + 2) * screen_height) + 3) & (~3);
    // PCIE_Write32(hDriver, PCIE_USER_BAR, REG_IMGSIZE, (uint32_t)img_size);

    edge = screen_width / 20;
    InitBlankScreen();
    InitFontMap();
    printf("character: %d * %d\n", edge, edge);

    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
#ifndef SIM_MODE
    pthread_create(&overlay_thread, &attr, Thread4Overlay, NULL);
#endif

    // printf("begin rendering\n");
    signal(SIGINT, intHandler);
    Render();

    pthread_attr_destroy(&attr);

    ClearFontMap();
}

int main()
{
    pthread_mutex_init(&render_overlay_mutex, NULL);
    pthread_cond_init (&render_overlay_cv, NULL);

#ifndef SIM_MODE
    hDriver = DanmakuHW_Open();
    if (!hDriver) {
        fprintf(stderr, "DanmakuHW_Open failed\n");
        exit(1);
    }
    {
        uint8_t edid[256];
        FILE* ef = fopen("edid_p2214.bin","rb");
        if(!ef){
            fprintf(stderr, "failed to load EDID\n");
            exit(1);
        }
        size_t len = fread(edid,1,sizeof(edid),ef);
        DanmakuHW_LoadEDID(hDriver, edid, len);
        fclose(ef);
    }
#endif

    InitQueen(&sliding_queen);
    InitQueen(&static_queen);

    int y = 0;
    for (int i = 0; i < SLIDING_LAYER_ROWS; i++) {
        for (int j = 0; j < SLIDING_LAYER_COLS; j++) {
            InitSliding(&sliding_layers[i][j], y);
        }
        y++;
    }
    for (int i = 0; i < NUM_STATIC_LAYER; i++) {
        InitStatic(&static_layers[i], i);
    }

    // enable UTF-8
    setlocale(LC_ALL, "");

    // set stdin as non-blocked
    int flags = fcntl(STDIN_FILENO, F_GETFL, 0);
    if (fcntl(STDIN_FILENO, F_SETFL, flags | O_NONBLOCK) != 0) {
        exit(1);
    }


    // while (true) {
        SubMain();
    // }

    /* Clean up and exit */
    pthread_mutex_destroy(&render_overlay_mutex);
    pthread_cond_destroy(&render_overlay_cv);
    pthread_exit(NULL);
    return 0;
}
