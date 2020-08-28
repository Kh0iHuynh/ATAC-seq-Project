library(ggplot2)
library(gridExtra)
library(VennDiagram)
library(jpeg)
library(plyr)
library(scales)

BR <- read.table("BRpeaks.txt",header = TRUE)
BR$rounded <- round(BR,digits=0)
BR2 <- count(BR$rounded)
BR2$percent <- BR2$freq/sum(BR2$freq)

print(BR2)

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



brain2 <- read.table("BRheightbyfeature.txt", header =TRUE)
ovary2 <- read.table("OVheightbyfeature.txt", header =TRUE)
eye2 <- read.table("EDheightbyfeature.txt", header =TRUE)
wing2 <- read.table("WDheightbyfeature.txt", header =TRUE)

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

#data4 <- read.table("all.txt",header=TRUE,sep="\t")
#coverage<-ggplot(data, aes(x=Coverage, y=Count, group=Tissue)) + geom_line(aes(color=Tissue)) + xlim(0, 10) + ggtitle("Coverage distribution of peaks \n by tissues") + theme_classic()

frip<-ggplot(data=data2, aes(x=Tissue, y=FRiP)) + geom_bar(stat="identity") + ggtitle("i/ FRiP score") + theme_classic()

BRhist <- ggplot(data=BR2, aes(x=PeakScore, y=percent)) + geom_bar(stat="identity") + ggtitle("Brain Peak Enrichment Histogram") + ylab("Frequency") + xlab("Fold Enrichment") + xlim(0,13) + ylim(0,0.5) + theme_classic()
OVhist <- ggplot(data=OV2, aes(x=PeakScore, y=percent)) + geom_bar(stat="identity") + ggtitle("Ovary Peak Enrichment Histogram") + ylab("Frequency") + xlab("Fold Enrichment") + xlim(0,13) + ylim(0,0.5) + theme_classic()
EDhist <- ggplot(data=ED2, aes(x=PeakScore, y=percent)) + geom_bar(stat="identity") + ggtitle("Eye Disc Peak Enrichment Histogram") + ylab("Frequency") + xlab("Fold Enrichment") + xlim(0,13) + ylim(0,0.5) + theme_classic()
WDhist <- ggplot(data=WD2, aes(x=PeakScore, y=percent)) + geom_bar(stat="identity") + ggtitle("Wing Disc Peak Enrichment Histogram") + ylab("Frequency") + xlab("Fold Enrichment") + xlim(0,13) + ylim(0,0.5) + theme_classic()

peakcount<-ggplot(data3, aes(x=Tissue, y=Count)) + geom_bar(stat="identity") + ggtitle("j/ Peak counts by tissues") + theme_classic()

brainplot <- ggplot(brain2, aes(x=brain2$Annotation, y=brain2$PeakScore)) + geom_boxplot() + ggtitle("a/Peak enrichment by feature \n for Brain") + ylim(0,12) + xlab("Annotation") + ylab("Fold Enrichment") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line = element_line(colour = "black"), axis.text.x = element_text(angle = 90, hjust = 1))
print("1")
ovaryplot <- ggplot(ovary2, aes(x=ovary2$Annotation, y=ovary2$PeakScore)) + geom_boxplot() + ggtitle("b/Peak enrichment by feature \n for Ovary") + ylim(0,12) + xlab("Annotation") + ylab("Fold Enrichment") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line = element_line(colour = "black"),axis.text.x = element_text(angle = 90, hjust = 1))
print("2")
eyeplot <- ggplot(eye2, aes(x=eye2$Annotation, y=eye2$PeakScore)) + geom_boxplot() + ggtitle("c/Peak enrichment by feature \n for Eye Disc") + ylim(0,12) + xlab("Annotation") + ylab("Fold Enrichment") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line = element_line(colour = "black"),axis.text.x = element_text(angle = 90, hjust = 1))
print("3")
wingplot <- ggplot(wing2, aes(x=wing2$Annotation, y=wing2$PeakScore)) + geom_boxplot() + ggtitle("d/Peak enrichment by feature \n for Wing Disc") + ylim(0,12) + xlab("Annotation") + ylab("Fold Enrichment") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line = element_line(colour = "black"),axis.text.x = element_text(angle = 90, hjust = 1))
print("4")


tssbrain <- ggplot(brain2, aes(x=brain2$DistancetoTSS, y=brain2$PeakScore)) + geom_point(size = 0.3) + ylim(0,12) + ggtitle("e/Peak enrichment by distance \n to TSS for Brain") + xlab("Distance to TSS") + ylab("Fold Enrichment") + theme_classic()
print("5")
tssovary <- ggplot(ovary2, aes(x=ovary2$DistancetoTSS, y=ovary2$PeakScore)) + geom_point(size = 0.3) + ylim(0,12) + ggtitle("f/Peak enrichment by distance \n to TSS for Ovary") + xlab("Distance to TSS") + ylab("Fold Enrichment") + theme_classic()
print("6")
tsseye <- ggplot(eye2, aes(x=eye2$DistancetoTSS, y=eye2$PeakScore)) + geom_point( size = 0.3) + ylim(0,12) + ggtitle("g/Peak enrichment by distance \n to TSS for Eye Disc") + xlab("Distance to TSS") + ylab("Fold Enrichment") + theme_classic()
print("7")
tsswing <- ggplot(wing2, aes(x=wing2$DistancetoTSS, y=wing2$PeakScore)) + geom_point( size = 0.3) + ylim(0,12) + ggtitle("h/Peak enrichment by distance \n to TSS for Wing Disc") + xlab("Distance to TSS") + ylab("Fold Enrichment") + theme_classic()
print("8")

#grid.arrange(frip, peakcount, tssbrain, tssovary, tsseye, tsswing, brainplot, ovaryplot, eyeplot, wingplot, ncol = 3)


offsets = data.frame(chrom=c("chrX","chr2L","chr2R","chr3L","chr3R"),off=cumsum(c(0,23542271,23513712,25286936,28110227)))
offsetPerPosbrain = brain$pos + offsets[match(brain$chr,offsets$chr),2]
offsetPerPosovary = ovary$pos + offsets[match(ovary$chr,offsets$chr),2]
offsetPerPoseye = eye$pos + offsets[match(eye$chr,offsets$chr),2]
offsetPerPoswing = wing$pos + offsets[match(wing$chr,offsets$chr),2]
print("9")
log102venn.plot <- draw.quad.venn(area1 = 17162, area2 = 13107, area3 = 13803, area4 = 13811, n12 = 3023, n13 = 3138, n14 = 3216, n23 = 7937, n24 = 4029,n34 = 4043, n123 = 2568 , n124 = 2045, n134 = 2065, n234 = 3361, n1234 = 1856, category = c("Brain", "Wing", "Eye","Ovary"),lty = "solid",fill = c("skyblue", "pink1","mediumorchid", "orange"), main = "Overlapped Peaks Between Tissues")

log103venn.plot <- draw.quad.venn(area1 = 16887, area2 = 13017, area3 = 13698, area4 = 13609, n12 = 3013, n13 = 3117, n14 = 3186, n23 = 7889, n24 = 4008,n34 = 4023, n123 = 2559, n124 = 2038, n134 = 2057, n234 = 3350, n1234 = 1850, category = c("Brain", "Wing", "Eye","Ovary"),lty = "solid",fill = c("skyblue", "pink1","mediumorchid", "orange"))


representative <- readJPEG('representive_region_chr3L_8,441,177_8,790,676.jpg')
representativezoom <- readJPEG('representive_region_chr3L_8,577,094_8,654,760.jpg')
representativezoom2 <- readJPEG('representive_region_chr3L_8,598,462_8,607,091.jpg')
# itissue
#manhattan with ggplot pannel

brainman <- ggplot(brain, aes(poskb, logp)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=logp, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,15000) + ggtitle("Manhattan -log10(p-value) Brain") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()
ovaryman <- ggplot(ovary, aes(poskb, logp)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=logp, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,15000) + ggtitle("Manhattan -log10(p-value) Ovary") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()
eyeman <- ggplot(eye, aes(poskb, logp)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=logp, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,15000) + ggtitle("Manhattan -log10(p-value) Eye Disc") + xlab("Position (Mb") + ylab("-log10(p-value)") + theme_classic()
wingman <- ggplot(wing, aes(poskb, logp)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=logp, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,15000) + ggtitle("Manhattan -log10(p-value) Wing Disc") + xlab("Position (Mb)") + ylab("-log10(p-value)") + theme_classic()

print("10")

brainman2 <- ggplot(brain, aes(poskb, Fold)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Fold, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,10) + ggtitle("Manhattan Fold Enrichment Brain") + xlab("Position (Mb)") + ylab("Fold Enrichment") + theme_classic()
ovaryman2 <- ggplot(ovary, aes(poskb, Fold)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Fold, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,10) + ggtitle("Manhattan Fold Enrichment Ovary") + xlab("Position (Mb)") + ylab("Fold Enrichment") + theme_classic()
eyeman2 <- ggplot(eye, aes(poskb, Fold)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Fold, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,10) + ggtitle("Manhattan Fold Enrichment Eye Disc") + xlab("Position (Mb)") + ylab("Fold Enrichment") + theme_classic()
wingman2 <- ggplot(wing, aes(poskb, Fold)) + geom_point(size=0.1) + facet_grid(. ~ chr) + stat_smooth(aes(y=Fold, x=poskb), method = lm, formula = y ~ poly(x, 10), se = FALSE) + ylim(0,10) + ggtitle("Manhattan Fold Enrichment Wing Disc") + xlab("Position (Mb)") + ylab("Fold Enrichment") + theme_classic()


print("11")

pdf("plot.pdf")

grid.arrange(brainplot,ovaryplot,eyeplot,wingplot,nrow = 2)
#grid.arrange(tssbrain,tssovary,tsseye,tsswing, nrow = 2)
grid.arrange(frip,peakcount,gTree(children=log102venn.plot),gTree(children=log103venn.plot), nrow = 2)
grid.arrange(BRhist,OVhist,EDhist,WDhist,nrow=2)
grid.arrange(brainman,ovaryman,eyeman,wingman,nrow=4)

grid.arrange(brainman2,ovaryman2,eyeman2,wingman2,nrow=4)



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



#attach(data4)
#coplot(Fold ~ pos | chr * Tissue, number= c(5,4),
#     panel=function(x,y,...) {
#     lines(ksmooth(pos, Fold, "normal", bandwidth = 1000000), col = 2)
#     } )
#
#
#coplot(logp ~ pos | chr * Tissue, number= c(5,4),
#     panel=function(x,y,...) {
#     lines(ksmooth(pos, logp, "normal", bandwidth = 1000000), col = 2)
#     } )
#detach(data4)



par(mfrow=c(2,2))
plot(offsetPerPosbrain/1e6,brain$logp,pch=".",main="Manhattan -log10(p-value) Brain",xlab="position (Mb)", ylab="-log10(p-value)",ylim=c(0,15000))
for (i in 2:5){abline(v=offsets[i,2]/1e6,col="red")}


plot(offsetPerPosovary/1e6,ovary$logp,pch=".",main="Manhattan -log10(p-value) Ovary",xlab="position (Mb)", ylab="-log10(p-value)",ylim=c(0,15000))
for (i in 2:5){abline(v=offsets[i,2]/1e6,col="red")}

plot(offsetPerPoseye/1e6,eye$logp,pch=".",main="Manhattan -log10(p-value) Eye Disc",xlab="position (Mb)", ylab="-log10(p-value)",ylim=c(0,15000))
for (i in 2:5){abline(v=offsets[i,2]/1e6,col="red")}



plot(offsetPerPoswing/1e6,wing$logp,pch=".",main="Manhattan -log10(p-value) Wing Disc",xlab="position (Mb)", ylab="-log10(p-value)",ylim=c(0,15000))
for (i in 2:5){abline(v=offsets[i,2]/1e6,col="red")}


par(mfrow=c(2,2))

plot(offsetPerPosbrain/1e6,brain$Fold,pch=".",main="Manhattan Fold Enrichment Brain",xlab="position (Mb)", ylab="Fold-enrichment",ylim=c(0,10))
for (i in 2:5){abline(v=offsets[i,2]/1e6,col="red")}

plot(offsetPerPosovary/1e6,ovary$Fold,pch=".",main="Manhattan Fold Enrichment Ovary",xlab="position (Mb)", ylab="Fold-enrichment",ylim=c(0,10))
for (i in 2:5){abline(v=offsets[i,2]/1e6,col="red")}

plot(offsetPerPoseye/1e6,eye$Fold,pch=".",main="Manhattan Fold Enrichment Eye Disc",xlab="position (Mb)", ylab="Fold-enrichment",ylim=c(0,10))
for (i in 2:5){abline(v=offsets[i,2]/1e6,col="red")}

plot(offsetPerPoswing/1e6,wing$Fold,pch=".",main="Manhattan Fold Enrichment Wing Disc",xlab="position (Mb)", ylab="Fold-enrichment",ylim=c(0,10))
for (i in 2:5){abline(v=offsets[i,2]/1e6,col="red")}


grid.arrange(rasterGrob(representative), rasterGrob(representativezoom),rasterGrob(representativezoom2),ncol=1, nrow =3, top ="Averaged Peaks at Different Zoom Level")

dev.off()


