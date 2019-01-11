#!/bin/bash


match=$1

fname="instances-$match.json"

if [ ! -f /tmp/$fname ]; then
    aws ec2 describe-instances --filters "Name=tag:Name,Values=*$match*" > /tmp/$fname
fi

cat /tmp/$fname | jq -r '.Reservations[]|.Instances[].Tags[]|select(.Key=="Name")|.Value'

