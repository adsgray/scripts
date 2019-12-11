#!/bin/bash

read -p "input: " inp

for f in $inp; do randomword $f|cut -b 1-5|tr '[sStTaAeEhHoOlL]' '[557744%%##0011]'|tr -d '\n'; done
echo ""
