#!/bin/bash

in=$1
out=$in.enc

gpg --armor --output $out --symmetric $in
