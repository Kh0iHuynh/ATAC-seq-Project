#!/bin/bash



######
# All peak files from 4 tissues are concatenated into temp.txt.
# temp.txt is then converted to file allpeak.txt which is input for the union.py (the averaging python script)
# allpeak.txt contains 4 columns: chromosome, peak start,peak end, peak summit.
######

cat onlyeu.*_peaks.narrowPeak > temp.txt
awk '{print $1,$2,$3,$2+$10}' temp.txt > allpeak.txt
rm temp.txt


######
# All peak are separted by chromosome and sorted by chromosome and peak summit.
# Union.py is then invoked with peak.txt as input to average the peaks.
# NOTE: Union.py will generate an artifial line at the end of peak.txt to by pass end of file termination.
# This is an error encounter when iterate line by line while set the last current line as variable.
######

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

#######
# generate artificial columns for viewing on browser
#######

awk -v OFS="\t" '{print $1,$2,$3,"peak","1000",".","10","-1","-1",int($4-$2)}' unionpeak.txt | sort -k1,1 -k2,2n > test2.bed

