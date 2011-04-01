
BIT_RATE=950000

   ffmpeg -i $1 -deinterlace -an -pass 1 -vcodec libx264 -vpre slowfirstpass -b \
   $BIT_RATE -threads 0 out1.mp4


   ffmpeg -i $1 -deinterlace -pass 2 -vcodec libx264 -vpre hq \
   -b $BIT_RATE -threads 0 -acodec copy out2.mp4

