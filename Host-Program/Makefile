TARGET = danmaku
CFLAGS += $(CFLAGS_EXTRA) -std=c11 `pkg-config freetype2 --cflags` -g3

LDFLAGS += -pthread

LIBS +=  `pkg-config freetype2 --libs-only-L` `pkg-config freetype2 --libs-only-l` `pkg-config freetype2 --libs-only-other` 

$(TARGET): danmaku_driver.o danmaku.o ring.o

	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
	