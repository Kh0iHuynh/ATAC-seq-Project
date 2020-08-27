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


#######
### scan for summit that is within (-500,500) from min or max
######

# if max is within 1kb from min, col 66 = col 67 and peaks are overlapped and averaged.
# if not, peaks are separated into 2 files based on distance to min, max

for i in {6..65};do
        awk -v i="$i" '{if(($i-$66 >= -500 && $i-$66 <=500) && ($i != "NA")) print $1,$2,$3,$4,$5,$i}' temp.txt >> min.txt
        awk -v i="$i" '{if(($i-$67 >= -500 && $i-$67 <=500) && ($i != "NA") && ($66 != $67)) print $1,$2,$3,$4,$5,$i}' temp.txt >> max.txt
done

awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6}' min.txt > mintemp.txt
sort -k1,1 -k2,2n mintemp.txt > mintempsort.txt
bedtools merge  -c 4,5,6 -o mean  -i mintempsort.txt > minfinal.txt
cat minfinal.txt | awk -v OFS="\t" '{print $1,$2,$3,"peak","1000",".",$4,$5,"-1",int($6-$2)}' > min.peaks.bed


awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6}' max.txt > maxtemp.txt
sort -k1,1 -k2,2n maxtemp.txt > maxtempsort.txt
bedtools merge  -c 4,5,6 -o mean  -i maxtempsort.txt > maxfinal.txt
cat maxfinal.txt | awk -v OFS="\t" '{print $1,$2,$3,"peak","1000",".",$4,$5,"-1",int($6-$2)}' > max.peaks.bed

cat min.peaks.bed max.peaks.bed > final.narrowPeak
