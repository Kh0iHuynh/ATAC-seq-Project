#!/bin/bash
#$ -N cov1
#$ -q pub8i
#$ -pe openmp 8
#$ -R y
#$ -t 1-1
#$ -ckpt blcr


awk '{print $1,$2+1}' cg.txt > covgeno.txt

awk '{print $1,$2+1}' ci.txt > covint.txt

######
# Generate peak postions that have snp or SV within 250bp
######
python cov.py


awk '{print $1,$2+1}' cg2.txt > lengeno.txt

awk '{print $1,$2+1}' ci2.txt > lenint.txt

python len.py

bash Snpsvindex.sh

