#!/usr/bin/env/python
import os
for line in open('C:/Users/Limbo/Desktop/result.CSV'):
    ID = line.split(',')[0]
    normal = line.split(',')[4]
    normal = normal.strip('\n')
    tumor = line.split(',')[2]
    fh = open('C:/data/%s.pbs '%ID,'a+')
    fh.write('#PBS -n %s_snp_result\n'%ID)
    fh.write('#PBS -l walltime=25:00:00\n#PBS -l nodes=1:ppn=1\n#PBS -S /bin/bash\n#PBS -q normal_3\n')
    fh.write('ref_file=/public/home/wangshx/songmf/prad_exon_facets/hg38.snp.vcf.gz\n')
    fh.write('normal=%s\n'%normal)
    fh.write('tumor=%s\n'%tumor)
    fh.write('cd $PBS_WORKDIR\nsource activate R\n')
    fh.write('snp-pileup -g -q15 -Q20 -P100 -r25,0 /public/home/wangshx/songmf/prad_exon_facets/hg38.snp.vcf.gz \\\n/public/home/wangshx/wx/snp_pbs/snp_output/%s.out.gz \\\n'%ID)
    fh.write('%s \\\n'%normal)
    fh.write('%s\n'%tumor)
    fh.close()