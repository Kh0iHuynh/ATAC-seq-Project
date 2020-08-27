mydata <- read.table("combine.txt", header = TRUE, sep = "\t")
norm <- rowMeans(mydata)
write.table(norm, file="name.txt",row.names=FALSE)
