#!/bin/bash
#$ -N ATACseq
#$ -q abio128
#$ -pe openmp 12
#$ -R y
#$ -t 1-4
#$ -ckpt blcr

module load enthought_python/7.3.2
module load python/2.7.2

files="/dfs3/bio/khoih/tissuelist.txt"
#tissuelist.txt is file contains 4 tissue name "BR","OV","ED","WD"
rawfix=`head -n $SGE_TASK_ID $files | tail -n 1`

samtools merge /dfs3/bio/khoih/backup2/all.${rawfix}.corrected.bam *BR*corrected.bam

macs2 callpeak -t /dfs3/bio/khoih/backup2/all.${rawfix}.corrected.bam -f BAMPE -n justbampe.${rawfix} -g 142573024 -p 0.01 --nomodel -B --SPMR --keep-dup all --call-summits
