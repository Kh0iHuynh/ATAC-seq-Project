
library(dplyr)
data <- read.table("peaknote.txt",header = TRUE)

samplemean = data %>% group_by(chr,peak_pos, genotype,tissue) %>% do(as.data.frame(mean(.$C)))
tissuemean = data %>% group_by(chr,peak_pos,tissue) %>% do(as.data.frame(mean(.$C)))

basemean = data %>% group_by(chr,peak_pos) %>% do(as.data.frame(mean(.$C)))
colnames(tissuemean) <- c("chr","peak_pos", "tissue", "mean")
colnames(samplemean) <- c("chr","peak_pos","genotype","tissue", "mean")
colnames(basemean) <- c("chr","peak_pos", "mean")

write.table(samplemean, file = "samplemean.txt", sep = "\t", quote= FALSE, row.names = FALSE, col.names=  TRUE)
write.table(tissuemean, file = "tissuemean.txt", sep = "\t" ,quote= FALSE, row.names = FALSE, col.names=  TRUE)

write.table(basemean, file = "basemean.txt", sep = "\t" ,quote= FALSE, row.names = FALSE, col.names=  TRUE)
