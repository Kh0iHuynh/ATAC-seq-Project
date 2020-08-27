#!/bin/bash

module load bedtools/2.25.0
module load R/3.4.1

cat *.narrowPeak > drlongtempcat.txt
awk -v OFS='\t' '{print $1, $2, $3, $7, $8,int($2+$10)}' drlongtempcat.txt > drlongtempawk.txt
sort -k1,1 -k2,2n drlongtempawk.txt > drlongtempsort.txt
bedtools merge  -c 4,5,6 -o mean,mean,collapse -i drlongtempsort.txt | sed 's/,/\t/g' > drlongtempmerge.bed
#cat drlongtempmerge.bed | awk '{print $1,$2,$3,".\t0\t.\t",$4,$5,"-1\t",$6-$2}' > /bio/khoih/drlong/drlongtempmerge.peaks.bed
rm drlongtempcat.txt drlongtempawk.txt drlongtempsort.txt

###############
# Then fill the column with NA to make all row having the same number of column
max=$(awk 'max < NF { max = NF } END { print max }'  drlongtempmerge.bed)

awk -v max=$max 'BEGIN{OFS=FS="\t"}{ for(i=NF+1; i<=max; i++) $i = "NA"; print }'  drlongtempmerge.bed > tempwithna.txt


######
# find min/max loci for the collapse peak summits.In our case, there are total of 65 columns in the tempwithna.txt
###
echo 'data <- read.table("tempwithna.txt", header=FALSE,sep="\t")' >getminmax.r
echo 'data[,66] <- apply(data[,6:65],1,min,na.rm = TRUE)' >> getminmax.r
echo 'data [,67] <- apply(data[,6:65],1,max,na.rm = TRUE)' >> getminmax.r
echo 'data[,68] <- ifelse(data[,67] - data[,66] < 1000, data[,66], data[,67])' >> getminmax.r
echo 'data[,67] <- NULL' >> getminmax.r
echo 'write.table(data, file = "temp.txt", append = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE,quotes =FALSE)' >> getminmax.r

Rscript getminmax.r
