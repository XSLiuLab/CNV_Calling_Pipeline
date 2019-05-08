#!/bin/bash

find /public/home/wangshx/wx/snp_pbs/pbs_file/data "*.pbs" -exec dos2unix {} \;

for file in /public/home/wangshx/wx/snp_pbs/pbs_file/data*.pbs
do

    qsub $file
done