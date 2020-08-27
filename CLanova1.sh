#!/bin/bash
#$ -N note
#$ -q bio,pub8i
#$ -pe openmp 2
#$ -R y
#$ -t 1-96
#$ -ckpt blcr


newdata="/dfs5/bio/khoih/backup"
files="/dfs5/bio/khoih/originalname2.txt"
rawfix=`head -n $SGE_TASK_ID $files | tail -n 1`


module purge
module load khoih/anaconda/3
source activate test


genotype=$(echo "$rawfix" | cut -f 2 -d "_")
tissue=$(echo "$rawfix" | cut -f 3 -d "_")
replicate=$(echo "$rawfix" | cut -f 4 -d "_")


tail -n +2 ../../withoutte/$rawfix/matrix.C.txt | sort -k1,1 -k2,2n - > $rawfix.tempC.txt
tail -n +2 ../../withoutte/$rawfix/matrix.L.txt | sort -k1,1 -k2,2n - > $rawfix.tempL.txt

paste -d"\t" $rawfix.tempC.txt $rawfix.tempL.txt > $rawfix.temp.txt

awk -v geno=$genotype -v tiss=$tissue -v rep=$replicate 'BEGIN{OFS=FS="\t"}{print $1,$2,$3,$6,geno,tiss,rep}' $rawfix.temp.txt > $rawfix.temp2.txt

######
#compared with summit reference to get only C/L at the summit for Anova
######
awk 'NR==FNR{a[$1,$2];next} ($1,$2) in a' ref.txt $rawfix.temp2.txt > $rawfix.temp3.txt

rm $rawfix.tempC.txt $rawfix.tempL.txt $rawfix.temp.txt $rawfix.temp2.txt
