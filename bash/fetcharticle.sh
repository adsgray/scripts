#!/bin/bash

# fetch a URL and save its text
# Note: required lynx

url=`echo $1|cut -d '?' -f 1`
tmpfile=`mktemp`
articledir=~/notes/article
width=70
useragent="Mozilla/5.0 Lynx (iPhone; CPU iPhone OS 6_0_1 like Mac OS X; nl-nl) AppleWebKit/536.26 (KHTML, like Gecko) CriOS/23.0.1271.96 Mobile/10A523 Safari/8536.25 (1C019986-AF73-46A7-8F31-0E86ADFFCDB4)"

# fetch raw HTML
lynx -useragent="$useragent" -source "$url" > $tmpfile

# extract and launder title
title=`cat $tmpfile | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si'`
title=$(echo $title|tr -d '|&')
title=$(echo $title|tr ' ' '_')

articlefile="$articledir/$title.txt"
echo "$url" > $articlefile
# extract text and save
lynx -dump -nomargins -width=$width -stdin < $tmpfile >> $articlefile

echo $articlefile
# for convenience, put filename in clipboard
echo $articlefile | pbcopy

rm $tmpfile
