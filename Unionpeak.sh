#!/bin/bash

rm unionpeak.txt

module load bedtools
# all peak sort by chromosome and summit
# union.py will generate an artifial line at the end of peak.txt to by pass end of file termination
awk '{if($1 == "chr2L") print}' allpeak.txt | sort -k1,1 -k4,4n > peak.txt
python union.py

awk '{if($1 == "chr2R") print}' allpeak.txt | sort -k1,1 -k4,4n > peak.txt
python union.py


awk '{if($1 == "chr3L") print}' allpeak.txt | sort -k1,1 -k4,4n > peak.txt
python union.py

awk '{if($1 == "chr3R") print}' allpeak.txt | sort -k1,1 -k4,4n > peak.txt
python union.py

awk '{if($1 == "chrX") print}' allpeak.txt | sort -k1,1 -k4,4n > peak.txt
python union.py

# generate artificial columns for viewing on browser
awk -v OFS="\t" '{print $1,$2,$3,"peak","1000",".","10","-1","-1",int($4-$2)}' unionpeak.txt | sort -k1,1 -k2,2n > test2.bed

