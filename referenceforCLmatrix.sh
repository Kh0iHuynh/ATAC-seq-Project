#!/bin/bash
module load bedtools

###
## bam.justbampe.final.narrowPeak is final averaged and union peak file
####
awk -F $'\t' 'BEGIN {OFS = FS}{ print $1,$2 + $10}' bam.justbampe.final.narrowPeak > delete.txt

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chr3R" && $2 > 4552934 && $2 < 31845060) print $0}' delete.txt > delete2.txt

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chrX" && $2 > 277911 && $2 < 22628490) print $0}' delete.txt >> delete2.txt

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chr3L" && $2 > 158639 && $2 < 22962476 ) print $0}' delete.txt >> delete2.txt

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chr2L" && $2 > 82455 && $2 < 22011009 ) print $0}' delete.txt >> delete2.txt

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chr2R" && $2 > 5398184 && $2 < 24684540 ) print $0}' delete.txt >> delete2.txt


awk 'BEGIN{OFS=FS="\t"}{print $1,$2,$2+1}' delete2.txt > delete3.txt

bedtools intersect -v -a delete3.txt -b /dfs5/bio/khoih/overlap.SV.bed > delete4.txt

awk 'BEGIN{OFS=FS="\t"}{print $1,$2}' delete4.txt | sort -k 1,1 -k2,2n > final2.bed

rm delete*.txt
