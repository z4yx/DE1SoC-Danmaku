TARGET = danmaku
CFLAGS += $(CFLAGS_EXTRA) -O2 -std=gnu99 `pkg-config glib-2.0 pango fontconfig pangoft2 freetype2 --cflags` -g3

LDFLAGS += -pthread

LIBS +=  `pkg-config --libs freetype2 glib-2.0 pango fontconfig pangoft2`

$(TARGET): danmaku_driver.o danmaku.o ring.o render.o gpios.o

	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
	