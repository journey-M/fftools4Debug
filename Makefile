CC = gcc
CFLAGS = -g
AVBASENAMES  = ffmpeg ffplay  ffprobe

OBJS-ffmpeg                        += ffmpeg_opt.o ffmpeg_filter.o ffmpeg_hw.o
OBJS-ffmpeg-$(CONFIG_LIBMFX)       += ffmpeg_qsv.o
ifndef CONFIG_VIDEOTOOLBOX
OBJS-ffmpeg-$(CONFIG_VDA)          += ffmpeg_videotoolbox.o
endif
OBJS-ffmpeg-$(CONFIG_VIDEOTOOLBOX) += ffmpeg_videotoolbox.o


all: $(AVBASENAMES)
	@echo "suCCess"

ffmpeg: ffmpeg.o cmdutils.o ffmpeg_opt.o ffmpeg_hw.o ffmpeg_qsv.o ffmpeg_filter.o
	$(CC) $(CFLAGS) -o ffmpeg ffmpeg.o cmdutils.o ffmpeg_opt.o ffmpeg_hw.o ffmpeg_qsv.o ffmpeg_filter.o -lavfilter -lswresample -lswscale -lavformat -lavcodec -lavutil -lm -lpthread

ffmpeg.o: ffmpeg.c
	$(CC) $(CFLAGS) -c $^

cmdutils.o: cmdutils.c
	$(CC) $(CFLAGS) -c $^

ffmpeg_opt.o: ffmpeg_opt.c
	$(CC) $(CFLAGS) -c $^

ffmpeg_hw.o: ffmpeg_hw.c
	$(CC) $(CFLAGS) -c $^

ffmpeg_qsv.o: ffmpeg_qsv.c
	$(CC) $(CFLAGS) -c $^

ffmpeg_filter.o: ffmpeg_filter.c
	$(CC) $(CFLAGS) -c $^

ffplay :ffplay.o cmdutils.o
	$(CC) $(CFLAGS) -o $@ $^ -lSDL2  -lavfilter -lswresample -lswscale -lavformat -lavcodec -lavutil -lm -lpthread

ffplay.o : ffplay.c
	$(CC) $(CFLAGS) -c $^

ffprobe : ffprobe.o cmdutils.o 
	$(CC) $(CFLAGS) -o $@ $^ -lavfilter -lswresample -lswscale -lavformat -lavcodec -lavutil -lm -lpthread




clean::
	$(RM) $(AVBASENAMES) *.o
