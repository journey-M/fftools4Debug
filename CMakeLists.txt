cmake_minimum_required(VERSION 3.10)

project(ffdebug VERSION 1.0)

add_definitions("-Wall -g")

#add ffmpeg libray
# add_library(avcodec SHARED IMPORTED)
# add_library(avutil SHARED IMPORTED)
# add_library(avformat SHARED IMPORTED)
# add_library(avswresample SHARED IMPORTED)
# add_library(avfilter SHARED IMPORTED)
# add_library(avresample SHARED IMPORTED)
# add_library(avswscale SHARED IMPORTED)
#
# set_target_properties(avcodec PROPERTIES IMPORTED_LOCATION /usr/lib/libavcodec.so)
#

add_library(cmdutils cmdutils.c)
add_library(ffmpeg_opt ffmpeg_opt.c)
add_library(ffmpeg_hw ffmpeg_hw.c)
add_library(ffmpeg_qsv ffmpeg_qsv.c)
add_library(ffmpeg_filter ffmpeg_filter.c)

add_executable(ffmpeg ffmpeg.c)
target_link_libraries(ffmpeg PUBLIC m pthread avcodec avutil avformat avfilter swresample swscale cmdutils ffmpeg_opt ffmpeg_hw ffmpeg_qsv ffmpeg_filter)

add_executable(ffplay ffplay.c)

target_link_libraries(ffplay PUBLIC cmdutils SDL2 m pthread avcodec avutil avformat avfilter swresample swscale )

add_executable(ffprobe ffprobe.c)
target_link_libraries(ffprobe PUBLIC m pthread avcodec avutil avformat avfilter swresample swscale cmdutils)

