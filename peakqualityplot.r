library(ggplot2)
library(gridExtra)
library(VennDiagram)
library(jpeg)
library(plyr)
library(scales)


######
# BRpeaks.txt,OVpeaks.txt,EDpeaks.txt,WDpeaks.txt are
# files that contain peak enrichment for all peaks 
# that are called for each tissue. 
# The peak enrichment are then rounded.
# The count function from plyr will count and output count for each 
# rounded peak enrichment.
# percent frequency = frequency/ total frequency.
# The out put of this steps are used for Peak enrichment histogram plot
######

BR <- read.table("BRpeaks.txt",header = TRUE)
BR$rounded <- round(BR,digits=0)
BR2 <- count(BR$rounded)
BR2$percent <- BR2$freq/sum(BR2$freq)

OV <- read.table("OVpeaks.txt",header = TRUE)
OV$rounded <- round(OV,digits=0)
OV2 <- count(OV$rounded)
OV2$percent <- OV2$freq/sum(OV2$freq)

ED <- read.table("EDpeaks.txt",header = TRUE)
ED$rounded <- round(ED,digits=0)
ED2 <- count(ED$rounded)
ED2$percent <- ED2$freq/sum(ED2$freq)

WD <- read.table("WDpeaks.txt",header = TRUE)
WD$rounded <- round(WD,digits=0)
WD2 <- count(WD$rounded)
WD2$percent <- WD2$freq/sum(WD2$freq)

######
# inputs are 4 columns files :peak enrichment, annotation for the peak,distance to TSS, tissue
# These inputs are used to generate peak enrichment vs distance to TSS plot
# and peak enrichment vs annotation feature type plot
######

brain2 <- read.table("BRheightbyfeature.txt", header =TRUE)
ovary2 <- read.table("OVheightbyfeature.txt", header =TRUE)
eye2 <- read.table("EDheightbyfeature.txt", header =TRUE)
wing2 <- read.table("WDheightbyfeature.txt", header =TRUE)

######
# BRpeak.txt, OVpeak.txt,EDpeak.txt,WDpeak.txt are 4 column files: chromsome of peak, position of peak,log(p-value) of peak, and peak enrichment
# Position of peaks are also converted to kb from b
######

brain <- read.table("BRpeak.txt",sep= "\t",header = TRUE)
brain$poskb <- brain$pos/1000000
ovary <- read.table("OVpeak.txt",sep= "\t",header = TRUE)
ovary$poskb <- ovary$pos/1000000
eye <- read.table("EDpeak.txt",sep= "\t",header = TRUE)
eye$poskb <- eye$pos/1000000
wing <- read.table("WDpeak.txt",sep= "\t",header = TRUE)
wing$poskb <- wing$pos/1000000


data <- read.table("heighttotal.txt", header = TRUE, sep =" ")
data2 <- read.table("score.txt",header = TRUE, sep = "\t")
data3 <- read.table("peakcount.txt",header = TRUE, sep =" ")

frip<-ggplot(data=data2, aes(x=Tissue, y=FRiP)) + geom_bar(stat="identity") + ggtitle("i/ FRiP score") + theme_classic()

######
# peak enrichment histogram plots for each tissue
######

BRhist <- ggplot(data=BR2, aes(x=PeakScore, y=percent)) + geom_bar(stat="identity") + ggtitle("Brain Peak Enrichment Histogram") + ylab("Frequency") + xlab("Fold Enrichment") + xlim(0,13) + ylim(0,0.5) + theme_classic()
OVhist <- ggplot(data=OV2, aes(x=PeakScore, y=percent)) + geom_bar(stat="identity") + ggtitle("Ovary Peak Enrichment Histogram") + ylab("Frequency") + xlab("Fold Enrichment") + xlim(0,13) + ylim(0,0.5) + theme_classic()
EDhist <- ggplot(data=ED2, aes(x=PeakScore, y=percent)) + geom_bar(stat="identity") + ggtitle("Eye Disc Peak Enrichment Histogram") + ylab("Frequency") + xlab("Fold Enrichment") + xlim(0,13) + ylim(0,0.5) + theme_classic()
WDhist <- ggplot(data=WD2, aes(x=PeakScore, y=percent)) + geom_bar(stat="identity") + ggtitle("Wing Disc Peak Enrichment Histogram") + ylab("Frequency") + xlab("Fold Enrichment") + xlim(0,13) + ylim(0,0.5) + theme_classic()

peakcount<-ggplot(data3, aes(x=Tissue, y=Count)) + geom_bar(stat="identity") + ggtitle("j/ Peak counts by tissues") + theme_classic()

######
# generate peak ennrichment by feature types for each tissue
######

brainplot <- ggplot(brain2, aes(x=brain2$Annotation, y=brain2$PeakScore)) + geom_boxplot() + ggtitle("a/Peak enrichment by feature \n for Brain") + ylim(0,12) + xlab("Annotation") + ylab("Fold Enrichment") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line = element_line(colour = "black"), axis.text.x = element_text(angle = 90, hjust = 1))
ovaryplot <- ggplot(ovary2, aes(x=ovary2$Annotation, y=ovary2$PeakScore)) + geom_boxplot() + ggtitle("b/Peak enrichment by feature \n for Ovary") + ylim(0,12) + xlab("Annotation") + ylab("Fold Enrichment") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line = element_line(colour = "black"),axis.text.x = element_text(angle = 90, hjust = 1))
eyeplot <- ggplot(eye2, aes(x=eye2$Annotation, y=eye2$PeakScore)) + geom_boxplot() + ggtitle("c/Peak enrichment by feature \n for Eye Disc") + ylim(0,12) + xlab("Annotation") + ylab("Fold Enrichment") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line = element_line(colour = "black"),axis.text.x = element_text(angle = 90, hjust = 1))
wingplot <- ggplot(wing2, aes(x=wing2$Annotation, y=wing2$PeakScore)) + geom_boxplot() + ggtitle("d/Peak enrichment by feature \n for Wing Disc") + ylim(0,12) + xlab("Annotation") + ylab("Fold Enrichment") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line = element_line(colour = "black"),axis.text.x = element_text(angle = 90, hjust = 1))


######
# generate peak enrichment by distance to trasncription starting site TSS
######

tssbrain <- ggplot(brain2, aes(x=brain2$DistancetoTSS, y=brain2$PeakScore)) + geom_point(size = 0.3) + ylim(0,12) + ggtitle("e/Peak enrichment by distance \n to TSS for Brain") + xlab("Distance to TSS") + ylab("Fold Enrichment") + theme_classic()
tssovary <- ggplot(ovary2, aes(x=ovary2$DistancetoTSS, y=ovary2$PeakScore)) + geom_point(size = 0.3) + ylim(0,12) + ggtitle("f/Peak enrichment by distance \n to TSS for Ovary") + xlab("Distance to TSS") + ylab("Fold Enrichment") + theme_classic()
tsseye <- ggplot(eye2, aes(x=eye2$DistancetoTSS, y=eye2$PeakScore)) + geom_point( size = 0.3) + ylim(0,12) + ggtitle("g/Peak enrichment by distance \n to TSS for Eye Disc") + xlab("Distance to TSS") + ylab("Fold Enrichment") + theme_classic()
tsswing <- ggplot(wing2, aes(x=wing2$DistancetoTSS, y=wing2$PeakScore)) + geom_point( size = 0.3) + ylim(0,12) + ggtitle("h/Peak enrichment by distance \n to TSS for Wing Disc") + xlab("Distance to TSS") + ylab("Fold Enrichment") + theme_classic()



######
# venn diagram plots to compared number of peaks overlapped between tissues 
# for peaks with -log(pvalue) >=2 and -log(pvalue) >=3 
######

######
# hardcode data for venn diagram log2
# these values are calculated by Homer venn diagram option
######
v1234 = 4780 #BROVEDWD
v123 = 1096  #BRWDED
v234 = 2233  #WDEDOV
v134 = 171  #BREDOV
v124 = 144  #BRWDOV
v12 = 220  #BRWD
v23 = 5382  #WDED
v24 = 295 # WDOV
v13 = 517 #BRED
v34 = 449 #EDOV
v14 = 1537 #BROV
v1 = 16753 #BR
v2 = 3149 #WD
v3 = 3755 #ED
v4 = 8375 #OV


######
# hardcode data for venn diagram log3
# these values are calculated by Homer venn diagram option
######
d1234 = 4750 #BROVEDWD
d123 = 1079  #BRWDED
d234 = 2211  #WDEDOV
d134 = 168  #BREDOV
d124 = 145  #BRWDOV
d12 = 210  #BRWD
d23 = 5346  #WDED
d24 = 281 # WDOV
d13 = 497 #BRED
d34 = 444 #EDOV
d14 = 1468 #BROV
d1 = 16078 #BR
d2 = 3000 #WD
d3 = 3577 #ED
d4 = 7991 #OV
print("pass")

log102venn.plot <- draw.quad.venn(area1 = v1+v12+v1234+v1234+v124+v13+v134+v14, area2 = v2+v12+v23+v123+v1234+v234+v24+v124, area3 = v3+v34+v23+v234+v123+v1234+v134+v13, area4 = v4+v34+v234+v24+v1234+v124+v134+v14, n12 = v12+v123+v1234+v124, n13 = v13 + v134 +v1234+v123, n14 = v14 + v134 +v124+ v1234, n23 = v23 + v123 + v1234 + v234, n24 = v24 + v234 + v1234 + v124,n34 = v34 + v234 + v1234 + v134, n123 = v123 + v1234 , n124 = v124 + v1234, n134 = v134 + v1234, n234 = v234 + v1234, n1234 = v1234, category = c("Brain", "Wing", "Eye","Ovary"),lty = "solid",fill = c("skyblue", "pink1","mediumorchid", "orange"), main = "Overlapped Peaks Between Tissues")

log103venn.plot <- draw.quad.venn(area1 = d1+d12+d1234+d1234+d124+d13+d134+d14, area2 = d2+d12+d23+d123+d1234+d234+d24+d124, area3 = d3+d34+d23+d234+d123+d1234+d134+d13, area4 = d4+d34+d234+d24+d1234+d124+d134+d14, n12 = d12+d123+d1234+d124, n13 = d13 + d134 +d1234+d123, n14 = d14 + d134 +d124+ d1234, n23 = d23 + d123 + d1234 + d234, n24 = d24 + d234 + d1234 + d124,n34 = d34 + d234 + d1234 + d134, n123 = d123 + d1234 , n124 = d124 + d1234, n134 = d134 + d1234, n234 = d234 + d1234, n1234 = d1234, category = c("Brain", "Wing", "Eye","Ovary"),lty = "solid",fill = c("skyblue", "pink1","mediumorchid", "orange"), main = "Overlapped Peaks Between Tissues")



representative <- readJPEG('representive_region_chr3L_8,441,177_8,790,676.jpg')
representativezoom <- readJPEG('representive_region_chr3L_8,577,094_8,654,760.jpg')
representativezoom2 <- readJPEG('representive_region_chr3L_8,598,462_8,607,091.jpg')

######
# manhattan plot scripts for log(p-value) and peak enrichment
######
brainman <- ggplot(brain, aes(poskb, logp)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=logp, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,15000) + ggtitle("Manhattan -log10(p-value) Brain") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()
ovaryman <- ggplot(ovary, aes(poskb, logp)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=logp, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,15000) + ggtitle("Manhattan -log10(p-value) Ovary") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()
eyeman <- ggplot(eye, aes(poskb, logp)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=logp, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,15000) + ggtitle("Manhattan -log10(p-value) Eye Disc") + xlab("Position (Mb") + ylab("-log10(p-value)") + theme_classic()
wingman <- ggplot(wing, aes(poskb, logp)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=logp, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,15000) + ggtitle("Manhattan -log10(p-value) Wing Disc") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()


brainman2 <- ggplot(brain, aes(poskb, Fold)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Fold, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,10) + ggtitle("Manhattan Fold Enrichment Brain") + xlab("Position (Mb)") + ylab("Fold Enrichment") + theme_classic()
ovaryman2 <- ggplot(ovary, aes(poskb, Fold)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Fold, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,10) + ggtitle("Manhattan Fold Enrichment Ovary") + xlab("Position (Mb)") + ylab("Fold Enrichment") + theme_classic()
eyeman2 <- ggplot(eye, aes(poskb, Fold)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Fold, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,10) + ggtitle("Manhattan Fold Enrichment Eye Disc") + xlab("Position (Mb)") + ylab("Fold Enrichment") + theme_classic()
wingman2 <- ggplot(wing, aes(poskb, Fold)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Fold, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,10) + ggtitle("Manhattan Fold Enrichment Wing Disc") + xlab("Position (Mb)") + ylab("Fold Enrichment") + theme_classic()


######
# generate pdf files and output all plots
######

pdf("plot.pdf")

grid.arrange(brainplot,ovaryplot,eyeplot,wingplot,nrow = 2)
grid.arrange(frip,peakcount,gTree(children=log102venn.plot),gTree(children=log103venn.plot), nrow = 2)
grid.arrange(BRhist,OVhist,EDhist,WDhist,nrow=2)
grid.arrange(brainman,ovaryman,eyeman,wingman,nrow=4)
grid.arrange(brainman2,ovaryman2,eyeman2,wingman2,nrow=4)


######
# plot peak enrichment vs distance to TSS of peaks
######
par(mfrow=c(2,2))
with(brain2, {
    plot(brain2$DistancetoTSS, brain2$PeakScore, xlim=c(-40000,40000),pch=16, cex=0.1,ylim=c(0,10), xlab="DistancetoTSS",ylab="Fold-enrichment",main="Brain Peak Enrichment\nby Distance to TSS")
    lines(ksmooth(brain2$DistancetoTSS, brain2$PeakScore, "normal", bandwidth = 1000), col = 2)
})

with(ovary2, {
    plot(ovary2$DistancetoTSS, ovary2$PeakScore, xlim=c(-40000,40000),pch=16, cex=0.1,ylim=c(0,10),xlab="DistancetoTSS",ylab="Fold-enrichment",main="Ovary Peak Enrichment\nby Distance to TSS")
    lines(ksmooth(ovary2$DistancetoTSS, ovary2$PeakScore, "normal", bandwidth = 1000), col = 2)
})

with(brain2, {
    plot(eye2$DistancetoTSS, eye2$PeakScore, xlim=c(-40000,40000),pch=16, cex=0.1,ylim=c(0,10),xlab="DistancetoTSS",ylab="Fold-enrichment",main="Eye Disc Peak Enrichment\nby Distance to TSS")
    lines(ksmooth(eye2$DistancetoTSS, eye2$PeakScore, "normal", bandwidth = 1000), col = 2)
})

with(wing2, {
    plot(wing2$DistancetoTSS, wing2$PeakScore, xlim=c(-40000,40000),pch=16, cex=0.1,ylim=c(0,10),xlab="DistancetoTSS",ylab="Fold-enrichment",main="Wing Disc Peak Enrichment\nby Distance to TSS")
    lines(ksmooth(wing2$DistancetoTSS, wing2$PeakScore, "normal", bandwidth = 1000), col = 2)
})

#######
# representative window from UCSC genome browser
#######

grid.arrange(rasterGrob(representative), rasterGrob(representativezoom),rasterGrob(representativezoom2),ncol=1, nrow =3, top ="Averaged Peaks at Different Zoom Level")

dev.off()


