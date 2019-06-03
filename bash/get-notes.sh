#!/bin/bash

aws --profile adsgray s3 cp s3://adsg-backup/notes/cbnotes.tar.gpg ~/notes/journal
gpg ~/notes/journal/cbnotes.tar.gpg
