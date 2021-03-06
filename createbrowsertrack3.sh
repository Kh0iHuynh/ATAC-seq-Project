#!/bin/bash
#$ -N list3.txt
#$ -q pub8i
#$ -pe openmp 1
#$ -R y
#$ -t 1-32
#$ -ckpt blcr

module purge
module load khoih/anaconda/3
source activate kent

# listname.txt is the list of all genotype and tissue combination so we can average C and L over triplicate 
files="./listname.txt"

rawfix=`head -n $SGE_TASK_ID $files | tail -n 1`


########
### generate bigwig files for browser
######
awk 'BEGIN{OFS="\t"}{print $1,$2,$2 + 1,$6}' ../meanc/${rawfix}.test2.txt > ../meanc/${rawfix}.bedgraph.txt


sed 's/"//g' ../meanc/${rawfix}.bedgraph.txt | sort -k1,1 -k2,2n - > ../meanc/${rawfix}.bdg
bedGraphToBigWig ../meanc/${rawfix}.bdg /dfs5/bio/khoih/kent/dm6.len ../meanc/${rawfix}.bw
