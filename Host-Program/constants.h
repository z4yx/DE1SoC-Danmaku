#ifndef CONSTANTS_H__
#define CONSTANTS_H__ 

// layer info
#define MAX_WIDTH       2000
#define MAX_HEIGHT      256
#define MAX_TEXT_LEN    512

#define SLIDING_LAYER_ROWS 5
#define SLIDING_LAYER_COLS 5
#define NUM_STATIC_LAYER 5

// screen info
#define MAX_SCREEN_HEIGHT 1100

// special colors
#define PXL_HSYNC (0xe)
#define PXL_VSYNC (0xf)
#define PXL_BLANK (0xd)

// parameters
#define FONT_FILE_PATH "SourceHanSansCN-Bold.otf"
#define CYCLE_PER_DANMU    512
#define DURATION           500

#define MAX_IMG_SIZE ((((MAX_WIDTH + 2) * MAX_SCREEN_HEIGHT) + 3) & (~3))
#define FRAME_BUFFER_SIZE MAX_IMG_SIZE
#define NUM_FRAME_BUFFER 5

#define QSYS_SYSTEMID 0xacd51302

#define PERPH_ADDR_BASE 0xff210000
#define PERPH_ADDR_SPAN 0x10000

#endif