library(ggplot2)
library(gridExtra)
library(jpeg)
library(plyr)
library(scales)
library(dplyr)

data <- read.table("top1.txt",sep ="\t",header = TRUE)
data$pos <- data$marker_pos/1000000

datascg = data %>% filter(type == "SCG")
datasci = data %>% filter(type == "SCI")
datasvcg = data %>% filter(type == "SVCG")
datasvci = data %>% filter(type == "SVCI")
datasli = data %>% filter(type == "SLI")
dataslg = data %>% filter(type == "SLG")
datasvli = data %>% filter(type == "SVLI")
datasvlg = data %>% filter(type == "SVLG")


scg <- ggplot(datascg, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SNPs for coverage by genotype") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

slg <- ggplot(dataslg, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SNPs for fragment length by genotype") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()


svcg <- ggplot(datasvcg, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SVs for coverage by genotype") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

svlg <- ggplot(datasvlg, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SVs for fragment length by genotype") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

sci <- ggplot(datasci, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SNPs for coverage by genotype:tissue interaction") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

sli <- ggplot(datasli, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SNPs for fragment length by genotype:tissue interaction") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()


svci <-ggplot(datasvci, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SVs for coverage by genotype:tissue interaction") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

svli <-ggplot(datasvli, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SVs for fragment length by genotype:tissue interaction") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()






data2 <- read.table("result.txt",sep ="\t",header = TRUE)
data2$pos <- data2$marker_pos/1000000

datascg2 = data2 %>% filter(type == "SCG")
datasci2 = data2 %>% filter(type == "SCI")
datasvcg2 = data2 %>% filter(type == "SVCG")
datasvci2 = data2 %>% filter(type == "SVCI")
datasli2 = data2 %>% filter(type == "SLI")
dataslg2 = data2 %>% filter(type == "SLG")
datasvli2 = data2 %>% filter(type == "SVLI")
datasvlg2 = data2 %>% filter(type == "SVLG")



scg2 <- ggplot(datascg2, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SNPs for coverage by genotype") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

slg2 <- ggplot(dataslg2, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SNPs for fragment length by genotype") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()


svcg2 <- ggplot(datasvcg2, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SVs for coverage by genotype") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

svlg2 <- ggplot(datasvlg2, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SVs for fragment length by genotype") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

sci2 <- ggplot(datasci2, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SNPs for coverage by genotype:tissue interaction") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

sli2 <- ggplot(datasli2, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SNPs for fragment length by genotype:tissue interaction") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()


svci2 <-ggplot(datasvci2, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SVs for coverage by genotype:tissue interaction") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()

svli2 <-ggplot(datasvli2, aes(x=percent)) + geom_histogram(color="black", fill="white") + aes(y=stat(count)/sum(stat(count))) + scale_y_continuous(labels = scales::percent) + ggtitle("Variance explained by SVs for fragment length by genotype:tissue interaction") + xlab("Percent Variance Explained") + ylab("Frequency") + ylim(0,0.5) + theme_classic()




grid.arrange(scg2,sci2,svcg2,svci2,ncol=1,nrow=4)
grid.arrange(slg2,sli2,svlg2,svli2,ncol=1,nrow=4)

grid.arrange(scg,sci,svcg,svci,ncol=1,nrow=4)
grid.arrange(slg,sli,svlg,svli,ncol=1,nrow=4)
