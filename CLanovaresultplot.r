library(ggplot2)
library(gridExtra)
library(VennDiagram)
library(jpeg)
library(plyr)
library(scales)
#######
# result.txt is the result from CLanova2.sh
#######

bigout <- read.table("result.txt",header = TRUE)
bigout <- as.data.frame(bigout)
bigout$poskb <- bigout$pos/1000000
N=nrow(bigout)

######
# generate Manhattan plot for -logp value for C Anova and L Anova
######
tissuec <- ggplot(bigout, aes(poskb,Clog10t)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Clog10t, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(4,25) + ggtitle("Manhattan -log10(p-value) C Tissue") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()

genotypec <- ggplot(bigout, aes(poskb,Clog10g)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Clog10g, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(4,25) + ggtitle("Manhattan -log10(p-value) C Genotype") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()

interactionc <- ggplot(bigout, aes(poskb,Clog10tbyg)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Clog10tbyg, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(4,25) + ggtitle("Manhattan -log10(p-value) C Genotype:Tissue") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()


tissuel <- ggplot(bigout, aes(poskb,Llog10t)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Llog10t, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(4,25) + ggtitle("Manhattan -log10(p-value) L Tissue") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()

genotypel <- ggplot(bigout, aes(poskb,Llog10g)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Llog10g, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(4,25) + ggtitle("Manhattan -log10(p-value) L Genotype") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()

interactionl <- ggplot(bigout, aes(poskb,Llog10tbyg)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Llog10tbyg, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(4,25) + ggtitle("Manhattan -log10(p-value) L Genotype:Tissue") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()

######
# generate residual plot for C (first plot command)
# generate qqplot for -logp value (2,3,4 plot commands)
######
attach(bigout)
par(mfrow=c(2,2))

plot(bigout$mC, bigout$residualC,pch=16, cex=0.1, ylim=c(0,1.5) ,xlab="mean log10(C)",ylab="Mean square residual",main="residual plot C")
plot(sort(-log10(1:N/N)),sort(Clog10t),pch=".", main="QQ tissue (log10C)",xlab="Theoretical -log(p-value)",ylab="Experimental -log(p-value)",ylim=c(0,25),xlim=c(0,5))
plot(sort(-log10(1:N/N)),sort(Clog10g),pch=".", main="QQ genotype (log10C)",xlab="Theoretical -log(p-value)",ylab="Experimental -log(p-value)",ylim=c(0,25),xlim=c(0,5))
plot(sort(-log10(1:N/N)),sort(Clog10tbyg),pch=".", main="QQ tiss:geno (log10C)",xlab="Theoretical -log(p-value)",ylab="Experimental -log(p-value)",ylim=c(0,25),xlim=c(0,5))
detach(bigout)
######
# draw Manhattan plot for C -logp
######
grid.arrange(tissuec,genotypec,interactionc, nrow = 2)

######
# generate residual plot for L (first plot command)
# generate qqplot for -logp value (2,3,4 plot commands)
######
attach(bigout)
par(mfrow=c(2,2))
plot(bigout$mL, bigout$residualL,pch=16, cex=0.1, xlab="mean L",ylab="Mean square residual",main="residual plot L")
plot(sort(-log10(1:N/N)),sort(Llog10t),pch=".", main="QQ tissue (L)",xlab="Theoretical -log(p-value)",ylab="Experimental -log(p-value)",ylim=c(0,25),xlim=c(0,5))
plot(sort(-log10(1:N/N)),sort(Llog10g),pch=".", main="QQ genotype (L)",xlab="Theoretical -log(p-value)",ylab="Experimental -log(p-value)",ylim=c(0,25),xlim=c(0,5))
plot(sort(-log10(1:N/N)),sort(Llog10tbyg),pch=".", main="QQ tiss:geno (L)",xlab="Theoretical -log(p-value)",ylab="Experimental -log(p-value)",ylim=c(0,25),xlim=c(0,5))
detach(bigout)
######
# draw Manhattan plot for L -logp
######
grid.arrange(tissuel,genotypel,interactionl, nrow = 2)
