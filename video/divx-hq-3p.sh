#!/bin/sh


bitrate=1250
description=`mythname.pl --description $1`
iname=`basename $1 .mpg`
tname="$iname.txt"

echo -n "fetching name... "
#oname=`getmythname.pl $1`
if [ "foo$oname" = "foo" ]; then
	tname="$iname.txt"
	oname="$iname.avi"
	echo "failed, using $iname"
else
	tname="$oname.txt"
	oname="$oname.avi"
	echo $oname
fi

#echo -n "fetching description... "
#mythname.pl --description $1 > $tname
#echo "done"
#cat $tname

mencoder $1 -oac copy -ovc lavc -lavcopts \
	vcodec=mpeg4:vpass=1:turbo:keyint=75:vmax_b_frames=0:dia=6:vbitrate=$bitrate \
	-noaspect \
	-ffourcc XVID -o $oname

	#-vf crop=656:304:46:102

mencoder $1 -oac copy -ovc lavc -lavcopts \
	vcodec=mpeg4:vpass=3:vhq:keyint=75:vmax_b_frames=0:dia=6:vbitrate=$bitrate \
	-noaspect \
	-ffourcc XVID -o $oname


mencoder $1 -oac copy -ovc lavc -lavcopts \
	vcodec=mpeg4:vpass=2:vhq:keyint=75:vmax_b_frames=0:dia=6:vbitrate=$bitrate:aspect=4/3 \
	-noaspect \
	-ffourcc XVID -o $oname



