#!/bin/bash
#$ -N relativedistance
#$ -q abio128,abio
#$ -pe openmp 1
#$ -R y
#$ -t 1-96
#$ -ckpt blcr

module load enthought_python/7.3.2
module load bwa/0.7.8
module load samtools/1.3
module load bcftools/1.3
module load gatk/2.4-7
module load picard-tools/1.87
module load java/1.7
module load bedtools/2.25.0
module load java
module load bowtie2/2.2.7

newdata="/dfs3/bio/khoih/backup"
# the folders...with the data
files="/dfs3/bio/khoih/originalname2.txt"
# I gave you a tar of this directoryref="/bio/khoih/ref/dm6.fa"
rawfix=`head -n $SGE_TASK_ID $files | tail -n 1`


#==============
#combine fragment count with total mean
#=================
paste ./$rawfix.final2.txt ./name.txt > ./$rawfix.withmean.txt


#================
#calculate weight
#===================

awk 'FNR > 1 {if ($1 > 0) { print $1, $2, $3= $2/$1 } else {print $1, $2,$3= "NA"} }' ./$rawfix.withmean.txt > ./$rawfix.weight.txt


#===================
#print only weight
#======================

awk '{ print $3 }' ./$rawfix.weight.txt >> ./$rawfix.weightnorm.txt


#========================
# combine fragment length with weight
#========================


paste -d " " ./$rawfix.weightnorm.txt ./fraglength.txt > ./$rawfix.ref.txt


#=====================================
#fragpost file is position , fragment length
#fragment length, position, weight
#=====================================
awk '{print $5,$4}'  /dfs3/bio/khoih/euonly/$rawfix.midpointposition.bed >  ./$rawfix.fragpost.txt

awk 'NR==FNR{a[$2]=$1;next;}{print $0 " " ($2 in a ? a[$2] : "0")}' ./$rawfix.ref.txt ./$rawfix.fragpost.txt > ./$rawfix.withweight.txt

paste /dfs3/bio/khoih/euonly/$rawfix.midpointposition.bed ./$rawfix.withweight.txt >  ./$rawfix.total.txt


##################
#print $1,$2,$3,$4,$8 to create fragfile for process.py
#column are chr,start,stop,length,weight
############
awk '{print $1,$2,$3,$4,$8 }'  ./$rawfix.total.txt >  ./fragfiles/$rawfix.withweight.txt
