#!/bin/bash

RFILE=$1
TCGALIST=$2

for i in $(cat ${TCGALIST})
do
sed -r "s/<head>/${i}/g" $RFILE >${i}_$RFILE
done
