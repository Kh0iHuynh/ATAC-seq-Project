#!/bin/bash
#$ -N tecat
#$ -q bio
#$ -pe openmp 1
#$ -R y
#$ -t 1

module load bedtools/2.25.0
module load R/3.4.1

#######
# echo header for CLtable.txt file with tab delimiter
#######
echo "chr     pos     C       L       genotype        tissue  replicate" > CLtable.txt

#######
# concatenated all temp3.txt files from 96 sample to CLtable.txt
#######
cat *.temp3.txt >> CLtable.txt

######
# run anova
######
Rscript CLanova.r


#####
# combine all results into 1 result file
####
head -n 1 test.txt > test3.txt
sort -k 1,1 -k2,2n test.txt >> test3.txt
head -n 1 test2.txt > test4.txt
sort -k 1,1 -k2,2n test2.txt >> test4.txt
paste -d" " test3.txt test4.txt > test5.txt
awk '{ $11=$12=""; print}' test5.txt > result.txt

