#ifndef DANMAKU_DRIVER_H__
#define DANMAKU_DRIVER_H__ 

#include <ctype.h>
#include <stdint.h>

typedef void* DANMAKU_HW_HANDLE;

DANMAKU_HW_HANDLE DanmakuHW_Open(void);
int DanmakuHW_FrameBufferTxmit(DANMAKU_HW_HANDLE h, int buf_index, uint32_t length);
int DanmakuHW_PendingTxmit(DANMAKU_HW_HANDLE h);
void DanmakuHW_LoadEDID(DANMAKU_HW_HANDLE h, uint8_t* content, uint32_t length);
uintptr_t DanmakuHW_GetFrameBuffer(DANMAKU_HW_HANDLE h, int buf_index);
void DanmakuHW_GetFrameSize(DANMAKU_HW_HANDLE h, int* height, int* width);


#endif