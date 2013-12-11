#!/bin/sh

# usage:
# $ dosql.sh myfile.sql

host=SERVER
db=DBNAME
user=user
pw=pw

# -t 
mysql -t --host=$host --user=$user --password=$pw $db < $*
