#!/bin/bash
#$ -N tecat
#$ -q bio
#$ -pe openmp 1
#$ -R y
#$ -t 1

module load bedtools/2.25.0
module load R/3.4.1




echo "chr     pos     C       L       genotype        tissue  replicate" > CLtable.txt

cat *.temp3.txt >> CLtable.txt

Rscript CLanova.r
