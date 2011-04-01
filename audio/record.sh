

for f in `seq -w 1 999`; do
	if [ ! -f $f.wav ]; then
		break
	fi
done

echo "arecord -f cd $f.wav"
arecord -f cd $f.wav
