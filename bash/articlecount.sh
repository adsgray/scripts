#!/bin/bash

zipdir=~/notes/article/zip
if [ -z $2 ]; then
    today=`date "+%Y-%m-%d"`
else
    today=$2
fi

todayfile="$zipdir/articles-$today.zip"

if [ -z $1 ]; then
    unzip -l $todayfile|grep "\.txt$"|wc -l
    exit
fi

unzip -l $todayfile
