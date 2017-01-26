#!/bin/bash

# make a zip file of saved articles
# in directory "zip"
# with filename "article-$TODAY.zip"

articledir=~/notes/article
today=`date "+%Y-%m-%d"`
zipdir="$articledir/zip"
bakdir="$articledir/bak"

mkdir -p $zipdir
mkdir -p $bakdir

cd $articledir
zip $zipdir/articles-$today.zip *.txt
mv *.txt $bakdir
