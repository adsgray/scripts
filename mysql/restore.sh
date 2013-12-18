#!/bin/bash

user=andrew
db=databasename
dumpfile=table.sql.gz

zcat dumpfile | mysql -u $user -p $db
