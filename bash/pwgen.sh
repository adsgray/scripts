#!/bin/bash

for f in $*; do randomword $f|cut -b 1-5|tr '[sStTaAeEhHoOlL]' '[557744%%##0011]'; done
