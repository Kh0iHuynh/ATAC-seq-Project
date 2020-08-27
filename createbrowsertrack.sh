#!/bin/bash
#$ -N list3.txt
#$ -q pub8i
#$ -pe openmp 1
#$ -R y
#$ -t 1-32
#$ -ckpt blcr

module purge
module load khoih/anaconda/3
source activate kent

# listname.txt is the list of all genotype and tissue combination so we can average C and L over triplicate 
files="./listname.txt"

rawfix=`head -n $SGE_TASK_ID $files | tail -n 1`

#######
# combined files by triplicate over genotype and tissue combinations
#######
paste ../${rawfix}*/temp4.C.txt > ../meanc/$rawfix.temp.txt
awk 'BEGIN{OFS="\t"}{print $1,$2,$3,$6,$9}' ../meanc/$rawfix.temp.txt > ../meanc/${rawfix}.test.txt
paste ../${rawfix}*/temp4.L.txt > ../meanl/$rawfix.temp.txt
awk 'BEGIN{OFS="\t"}{print $1,$2,$3,$6,$9}' ../meanl/$rawfix.temp.txt > ../meanl/${rawfix}.test.txt

########
# caculate mean c for triplicates
########
echo 'name <- list("Sample_A4_BR","Sample_A4_ED","Sample_A4_OV","Sample_A4_WD","Sample_A5_BR","Sample_A5_ED","Sample_A5_OV","Sample_A5_WD","Sample_A6_BR","Sample_A6_ED","Sample_A6_OV","Sample_A6_WD","Sample_A7_BR","Sample_A7_ED","Sample_A7_OV","Sample_A7_WD","Sample_B2_BR","Sample_B2_ED","Sample_B2_OV","Sample_B2_WD","Sample_B3_BR","Sample_B3_ED","Sample_B3_OV","Sample_B3_WD","Sample_B6_BR","Sample_B6_ED","Sample_B6_OV","Sample_B6_WD","Sample_B7_BR","Sample_B7_ED","Sample_B7_OV","Sample_B7_WD")' > mean.r


echo 'for(i in name){' >> mean.r
echo 'name2<- paste(i, ".test.txt",sep = "")' >> mean.r
echo 'name3<- paste(i, ".test2.txt",sep = "")' >> mean.r

echo 'data<- read.table(name2, header = TRUE)' >> mean.r
echo 'data[,6] <- rowMeans(data[,3:5])' >> mean.r
echo 'write.table(data, name3, sep = " ",row.names = FALSE, col.names = FALSE)' >> mean.r
echo '}' >> mean.r
Rscript mean.r
########
### generate bigwig files for browser
######
awk 'BEGIN{OFS="\t"}{print $1,$2,$2 + 1,$6}' ../meanc/${rawfix}.test2.txt > ../meanc/${rawfix}.bedgraph.txt


sed 's/"//g' ../meanc/${rawfix}.bedgraph.txt | sort -k1,1 -k2,2n - > ../meanc/${rawfix}.bdg
bedGraphToBigWig ../meanc/${rawfix}.bdg /dfs5/bio/khoih/kent/dm6.len ../meanc/${rawfix}.bw
