# atacseq

## processing read sequencing data to bam file:

raw reads have their nextera adapter cut with trimgalore which is a wrap for cutadapt. Then, they are aligned with bwa, and have properly paired reads kept.Afterward, I remove orphan reads, read pairs mapping to different chromosomes, and duplicates. The bams files are then convert to bedpe files which have their position shifted via bedtools; the bam files are also have their position shifted directly into new version of bam files via samtools. The bedpe files from corrected bam files don't have their coordinates shifted via bedtools and awk.

After getting bed files, fragment distribution plots are produced, and we decided not to use fat body and embryo samples.

## fragment counts are normalized between 96 samples (no fatbody, not embryo samples):

After getting the bed files, fragment lengths and counts are calculated for all samples.They are also normalized via weight factor which is equal to count/mean count for each fragment length. Here is where I did wrong. Originally, I normalized the read count by mid point base pair when generated vplot instead of whole genome normalization. However, you have pointed this out and it was fixed. All samples are normalized by whole genome now. 

Note: I know you will need some qc steps to validate the normalization so I generate these after normalizing by whole genome. These are scatter plot of all read counts per fragment lengths of each sample:

Figure A: scatter matrix plot using car package in R to show the scatter plot of raw fragment count for all fragments that are less than 1000 bp in length. The plot shows that all normalized fragment counts between samples have weak relationship and scatters which indicates no normalization. The fragment distributions are different and are also shown in diagonal line of sample names.
![](rawscatterplot.jpg)

Figure B: scatter matrix plot using car package in R to show the scatter plot of normalized fragment count for all fragments that are less than 1000 bp in length. The plot shows that all normalized fragment counts between samples have linear relationship. The fragment distribution after normalization are also shown in diagonal line of sample names.
![](normalizedscatterplot.jpg)

The normalized plot shows the colinear relationship between samples which indicates the successful normalization.

## Vplot parameter: 

vplot for hairy gene promoter was made with different parameter to test for the smoothness of kernel density function. We decided to go with bin (40,40) and 40 grid points. 

## Combine all samples by tissue and peak calling/annotation:

All samples are then combined by tissues and MACS2 is used to do peak calling. Then, an union bed of all peak was produced. Originally, I tested MAnorm to make the union bed; however, MAnorm is both computing intensive and allows only two samples at one time.Threfore, I have been using the linux script to concatenate, average peak summit based on min and max range of peak summit to avoid incorrect peak merging due to bookended issue (min and max are found using R). 

The peak files from MACS2 are also annotated by HOMER2. The first 800 or so peak on chr3R from union bed file are used to generate vplots and to test for pattern differential analysis. These vplot shows that peaks are different by feature type and tissue type. However, I am figuring out different way to statisticaly test for this in addition to "by eye" via averaged vplot. 

However, this is where I am currently stuck at. Thre are a couple things I need to make sure that they are perfectly done (gold standar) before pull the trigger on whole genome scan and classification:

1/ The union peak file is merged correctly. I have gone through most peaks but there might still be a few regions that get weird merge.
2/ testing different methods to analyze patterns beside PCA and manova. I am thinking of adding in Fisher LDA.
3/ Testing out splitting corrected bam files into different fragment lengths to represent different chromatin accessbility (0 vs 1 vs 2 vs 3 nucleosome).
4/ Using deseq2 to analyze peak count and also testing out your script+figuring out how to use the data. 

All of thise should be done by mid quater and ground work for model training and classification of feature types should be done by the end of this quarter.
