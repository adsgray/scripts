#!/bin/bash

# NOTE: must do "gpg --generate-key" to create 'backup' key (or import 'backup' public key into gpg keyring)
# create a tar file, encrypt it, and upload it to s3

DIR=~/notes/journal
DEST=/tmp/notes
notesfiles="2017.org compasscards.org curling/ dream.tmpl elfeed.org librarycards.org meeting.tmpl note.tmpl notes.org todo.tmpl url.org work.org"

mkdir -p $DEST

cd $DIR
tar cf $DEST/notes.tar $notesfiles

cd $DEST
gpg --encrypt --recipient backup notes.tar
rm notes.tar
mkdir notes
mv notes.tar.gpg notes
upload-to-s3.sh notes
