#!/bin/bash
module load R/3.4.1

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
