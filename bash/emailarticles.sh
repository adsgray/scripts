#!/bin/bash

# requires:
# brew install sendemail

. ~/notes/secrets

msgfile=`mktemp`
articledir=~/notes/article

if [ -z $1 ]; then
    today=`date "+%Y-%m-%d"`
else
    today=$1
fi

zipdir="$articledir/zip"
articlezipfile=articles-$today.zip

cd $zipdir

if [ -f $articlezipfile ]; then
    subject="articles $today"
    echo "Articles for ${today}:" > $msgfile
    articlecount.sh list $today >> $msgfile
    sendemail -f $gmailaddress -t $gmailaddress -a $articlezipfile -s smtp.gmail.com -o tls=yes -xu $gmailusername -xp $gapppassword -u $subject -o message-file=$msgfile
    rm $msgfile
else
    echo "$articlezipfile not found in $zipdir"
fi
