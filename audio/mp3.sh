#!/bin/sh

for f in *.wav; do
	bn=`basename $f .wav`
	echo $bn
	#lame -m s -v -b 64 -B 256 -h $bn.wav $bn.mp3
	lame -m s --vbr-new -b 64 -B 512 -h $bn.wav $bn.mp3
done
