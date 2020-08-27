#!/bin/bash
#$ -N generatefrag
#$ -q abio*
#$ -pe openmp 4
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

newdata="/dfs5/bio/khoih/backup"
# the folders...with the data
files="./originalname2.txt"
# I gave you a tar of this directoryref="/bio/khoih/ref/dm6.fa"
rawfix=`head -n $SGE_TASK_ID $files | tail -n 1`


awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chr3R" && $2 > 4552934 && $2 < 31845060 && $3 > 4552934 && $3 < 31845060 && $5 > 4552934 && $5 < 31845060 && $6 > 4552934 && $6 < 31845060 ) print $0}' /dfs5/bio/khoih/beforedownsampling/$rawfix.shifted.bed > /dfs5/bio/khoih/beforedownsampling/$rawfix.onlyeuchromatin.bed

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chrX" && $2 > 277911 && $2 < 22628490 && $3 > 277911 && $3 < 22628490 && $5 > 277911 && $5 < 22628490 && $6 > 277911 && $6 < 22628490 ) print $0}' /dfs5/bio/khoih/beforedownsampling/$rawfix.shifted.bed >> /dfs5/bio/khoih/beforedownsampling/$rawfix.onlyeuchromatin.bed

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chr3L" && $2 > 158639 && $2 < 22962476 && $3 > 158639 && $3 < 22962476 && $5 > 158639 && $5 < 22962476 && $6 > 158639 && $6 < 22962476 ) print $0}' /dfs5/bio/khoih/beforedownsampling/$rawfix.shifted.bed >> /dfs5/bio/khoih/beforedownsampling/$rawfix.onlyeuchromatin.bed

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chr2L" && $2 > 82455 && $2 < 22011009 && $3 > 82455 && $3 < 22011009 && $5 > 82455 && $5 < 22011009 && $6 > 82455 && $6 < 22011009 ) print $0}' /dfs5/bio/khoih/beforedownsampling/$rawfix.shifted.bed >> /dfs5/bio/khoih/beforedownsampling/$rawfix.onlyeuchromatin.bed

awk -F $'\t' 'BEGIN {OFS = FS}{ if($1 == "chr2R" && $2 > 5398184 && $2 < 24684540 && $3 > 5398184 && $3 < 24684540 && $5 > 5398184 && $5 < 24684540 && $6 > 5398184 && $6 < 24684540 ) print $0}' /dfs5/bio/khoih/beforedownsampling/$rawfix.shifted.bed >> /dfs5/bio/khoih/beforedownsampling/$rawfix.onlyeuchromatin.bed
#get fragment length
awk '{ if ($9 == "-" ) {$11 = $3 - $5 } else if ($9 == "+") { $11 = $6 - $2 } print $0 }' /dfs5/bio/khoih/beforedownsampling/$rawfix.onlyeuchromatin.bed > /dfs5/bio/khoih/euonly/$rawfix.fragmentlength.bed
awk '{ if($9 == "-" && $11 > 0 ) {print $1,$5,$3, $11} else if($9 == "+" && $11 > 0) {print $1,$2,$6,$11}}' /dfs5/bio/khoih/euonly/$rawfix.fragmentlength.bed | sed 's/ /\t/g' > /dfs5/bio/khoih/euonly/$rawfix.fragmentlengthtemp.bed
bedtools intersect -v -a /dfs5/bio/khoih/euonly/$rawfix.fragmentlengthtemp.bed -b /dfs5/bio/khoih/overlap.SV.bed > /dfs5/bio/khoih/euonly/$rawfix.fragmentlength2.bed
########################
#calculate midpoint
#######################
awk '{ print $1,$2,$3,$4,$5 = $2 + int($4/2) }' /dfs5/bio/khoih/euonly/$rawfix.fragmentlength2.bed > /dfs5/bio/khoih/euonly/$rawfix.midpointposition.bed
#=================
#getall fraglength
#==================
awk '{ if ($4>0) print $4}' /dfs5/bio/khoih/euonly/$rawfix.midpointposition.bed > /dfs5/bio/khoih/euonly/$rawfix.count.txt
#=============================
#get fragmenth count (frag length is second column and count is the first)
#=============================
sort /dfs5/bio/khoih/euonly/$rawfix.count.txt | uniq -c > /dfs5/bio/khoih/euonly/$rawfix.fragment_length_count.txt
sort -nk2 /dfs5/bio/khoih/euonly/$rawfix.fragment_length_count.txt > /dfs5/bio/khoih/euonly/$rawfix.sortedcount.txt
#================================
# compare and add missing length
#=================================
awk 'NR==FNR{a[$2]=$1;next;}{print $0 " " ($2 in a ? a[$2] : "0")}' /dfs5/bio/khoih/euonly/$rawfix.sortedcount.txt /dfs5/bio/khoih/euonly/length.txt > /dfs5/bio/khoih/euonly/$rawfix.2.txt
#==============================
#adding header and isolate frag count
#=============================
echo "$rawfix" >  /dfs5/bio/khoih/euonly/$rawfix.final.txt
awk '{print $3}' /dfs5/bio/khoih/euonly/$rawfix.2.txt >> /dfs5/bio/khoih/euonly/$rawfix.final.txt
#=========================
#take fraglength to max 1000
#=======================

        #rm /bio/khoih/qc/$locus/$rawfix.2.$locus.txt

head -1001 /dfs5/bio/khoih/euonly/$rawfix.final.txt > /dfs5/bio/khoih/euonly/$rawfix.final2.txt
