#!/bin/bash

zipdir=~/notes/article/zip
today=`date "+%Y-%m-%d"`
todayfile="$zipdir/articles-$today.zip"

if [ -z $1 ]; then
    unzip -l $todayfile|grep "\.txt$"|wc -l
    exit
fi

unzip -l $todayfile
