#!/bin/bash
#$ -N testrun
#$ -q bio,abio*,free*
#$ -pe openmp 48
#$ -R y
#$ -t 1-96
#$ -ckpt blcr


newdata="/dfs5/bio/khoih/euonly"
files="./name.txt"
rawfix=`head -n $SGE_TASK_ID $files | tail -n 1`

module purge
module load khoih/anaconda/3
source activate test

###
# rawfix is the name of 96 samples
###
mkdir $rawfix
rm $rawfix/matrix*
######
# sorted by chromosome,start.end
######
sort -k1,1 -k2,2n ./fragfiles/$rawfix.withweight.txt > $rawfix.test.txt

######
# intersect fragment files with reference avareged single base peaks 
# to find all fragments that span those single base peaks
######
bedtools intersect -sorted -a final2.bed -b $rawfix.test.txt -wa -wb > temp.$rawfix.txt
awk 'BEGIN { OFS = "\t"}{print $4,$5,$6,$7,$8,$1,$2,$3}' temp.$rawfix.txt > $rawfix.withweight.txt

######
# use CL.py to calculate for C and L
######
python CL.py -b final2 -f $rawfix
