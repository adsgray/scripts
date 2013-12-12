#!/bin/bash

user=andrew
db=databasename
table=tablename

mysqldump --user=$user -p $db $table > member.sql
