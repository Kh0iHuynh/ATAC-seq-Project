#!/bin/bash

module load R/3.4.1

paste *final2.txt > combine.txt

echo 'mydata <- read.table("combine.txt", header = TRUE, sep = "\t")' > mean.r
echo 'norm <- rowMeans(mydata)' >> mean.r
echo 'write.table(norm, file="name.txt",row.names=FALSE)' >> mean.r

Rscript mean.r
