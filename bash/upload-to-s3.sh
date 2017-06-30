#!/bin/bash

# run it like:
# upload-to-s3.sh blah
# where blah is a directory with files in it.
# That "folder" will be created in S3_BUCKET and all of the files will be uploaded to it.

# config.sh must:
# export AWS_ACCESS_KEY_ID="KEY_ID"
# export AWS_SECRET_ACCESS_KEY="ACCESS_KEY"
. ~/.ssh/config.sh

export S3_BUCKET="adsg-backup"
FOLDER="$1"
FILES="$1/*"

for f in $FILES; do
    aws s3 cp "$f" "s3://$S3_BUCKET/$f"
done
