#!/bin/bash


#######
# find number of overlapping peaks between tissue with HOMER mergePeaks for peak with -logp >=2
#######

mergePeaks -d 100 ../onlyeu.BR_peaks.narrowPeak ../onlyeu.WD_peaks.narrowPeak ../onlyeu.ED_peaks.narrowPeak ../onlyeu.OV_peaks.narrowPeak -prefix two -venn venn.txt

#######
# filter out any peaks that have -logp >=3
#######

awk 'BEGIN{OFS=FS="\t"}{ if( $8 >= 3) print $0}' ../../onlyeu.BR_peaks.narrowPeak > BR.txt

awk 'BEGIN{OFS=FS="\t"}{ if( $8 >= 3) print $0}' ../../onlyeu.OV_peaks.narrowPeak > OV.txt

awk 'BEGIN{OFS=FS="\t"}{ if( $8 >= 3) print $0}' ../../onlyeu.ED_peaks.narrowPeak > ED.txt

awk 'BEGIN{OFS=FS="\t"}{ if( $8 >= 3) print $0}' ../../onlyeu.WD_peaks.narrowPeak > WD.txt

#######
# find number of overlapping peaks between tissue with HOMER mergePeaks for peak with -logp >= 3
#######

mergePeaks -d 100 BR.txt OV.txt ED.txt WD.txt -prefix three -venn venn.txt
