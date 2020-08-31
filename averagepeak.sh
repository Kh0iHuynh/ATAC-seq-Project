#!/bin/bash

module load bedtools/2.25.0
module load R/3.4.1

#######
# concatenate all peak files into one for bedtools merge
#######
cat *.narrowPeak > tempcat.txt

######
# convert narrowpeak file format into a normal bed files format with columns as: 
# chromosome, start,end, peak enrichment, and p-value of peak
# Then, the file was sort based on chromosome and region start
######
awk -v OFS='\t' '{print $1, $2, $3, $7, $8,int($2+$10)}' tempcat.txt > tempawk.txt
sort -k1,1 -k2,2n tempawk.txt > tempsort.txt

######
# bedtools merge to merge all overlap regions using values in chromsome,start,end columns
# for peak enrichment, peak p-value, they are averaged over 4 tissues
# for peak summit (peaks in our paper) , they are collapse to create a group of peaks for 
# the merged regions rather than averaged
######
bedtools merge  -c 4,5,6 -o mean,mean,collapse -i tempsort.txt | sed 's/,/\t/g' > tempmerge.bed


######
# Then fill the column with NA to make all row having the same number of column
######
max=$(awk 'max < NF { max = NF } END { print max }'  tempmerge.bed)
awk -v max=$max 'BEGIN{OFS=FS="\t"}{ for(i=NF+1; i<=max; i++) $i = "NA"; print }'  tempmerge.bed > tempwithna.txt


######
# find min/max loci for the collapsed peak summits.In our case, there are total of 65 columns in the tempwithna.txt
######
echo 'data <- read.table("tempwithna.txt", header=FALSE,sep="\t")' >getminmax.r
echo 'data[,66] <- apply(data[,6:65],1,min,na.rm = TRUE)' >> getminmax.r
echo 'data [,67] <- apply(data[,6:65],1,max,na.rm = TRUE)' >> getminmax.r
echo 'data[,68] <- ifelse(data[,67] - data[,66] < 1000, data[,66], data[,67])' >> getminmax.r
echo 'data[,67] <- NULL' >> getminmax.r
echo 'write.table(data, file = "temp.txt", append = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE,quotes =FALSE)' >> getminmax.r
Rscript getminmax.r


######
# scan for summit that is within (-500,500) from min or max
# other.txt contains peak summits that are not within (-500,500) from min or max
# other.txt is then renamed to tempawk.txt and the script is run against from line 8 until we get an empty other.txt
######

for i in {6..16};do
        awk -v i="$i" '{if(($i-$17 >= -500 && $i-$17 <=500) && ($i != "NA")) print $1,$2,$3,$4,$5,$i}' temp.txt >> min.txt
        awk -v i="$i" '{if(($i-$18 >= -500 && $i-$18 <=500) && ($i != "NA") && ($17 != $18)) print $1,$2,$3,$4,$5,$i}' temp.txt >> max.txt
        awk -v i="$i" '{if(($i-$18 <= -500 ) && ($i-$17 >=500) && ($i != "NA") && ($17 != $18)) print $1,$2,$3,$4,$5,$i}' temp.txt >> other.txt
done

awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6}' min.txt > mintemp.txt
sort -k1,1 -k2,2n mintemp.txt > mintempsort.txt
bedtools merge  -c 4,5,6 -o mean  -i mintempsort.txt > minfinal.txt
cat minfinal.txt | awk -v OFS="\t" '{print $1,$2,$3,"peak","1000",".",$4,$5,"-1",int($6-$2)}' > min.peaks.bed

awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6}' max.txt > maxtemp.txt
sort -k1,1 -k2,2n maxtemp.txt > maxtempsort.txt
bedtools merge  -c 4,5,6 -o mean  -i maxtempsort.txt > maxfinal.txt
cat maxfinal.txt | awk -v OFS="\t" '{print $1,$2,$3,"peak","1000",".",$4,$5,"-1",int($6-$2)}' > max.peaks.bed
cat min.peaks.bed max.peaks.bed >> final.narrowPeak
