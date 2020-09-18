#!/bin/bash


aawk  -F'\t' 'BEGIN{OFS="\t";} {if($8 >= 2) print $1,$2 + $10 - 1,$2 + $10 + 1,$4,$7,"+";}' ../../../onlyeu.OV_peaks.narrowPeak > OV.peakannotation.txt
perl /dfs5/bio/khoih/homer/bin/annotatePeaks.pl OV.peakannotation.txt dm6 > OV.peakannotation.2.txt



awk  -F'\t' 'BEGIN{OFS="\t";} {if($8>= 2) print $1,$2 + $10 - 1,$2 + $10 + 1,$4,$7,"+";}' ../../../onlyeu.BR_peaks.narrowPeak > BR.peakannotation.txt
perl /dfs5/bio/khoih/homer/bin/annotatePeaks.pl BR.peakannotation.txt dm6 > BR.peakannotation.2.txt


awk  -F'\t' 'BEGIN{OFS="\t";} {if($8>= 2) print $1,$2 + $10 - 1,$2 + $10 + 1,$4,$7,"+";}' ../../../onlyeu.WD_peaks.narrowPeak > WD.peakannotation.txt
perl /dfs5/bio/khoih/homer/bin/annotatePeaks.pl WD.peakannotation.txt dm6 > WD.peakannotation.2.txt



awk  -F'\t' 'BEGIN{OFS="\t";} {if($8>= 2) print $1,$2 + $10 - 1,$2 + $10 + 1,$4,$7,"+";}' ../../../onlyeu.ED_peaks.narrowPeak > ED.peakannotation.txt
perl /dfs5/bio/khoih/homer/bin/annotatePeaks.pl ED.peakannotation.txt dm6 > ED.peakannotation.2.txt

