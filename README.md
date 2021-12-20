# **ATAC-seq Project:**

## Raw sequence data processing. 

+ The main script is bamprocess.sh. It is used for:
  - Trimming of the adapter from raw data (BioProject: PRJNA761571) using Trimgalore-0.4.5
  - Aligning trimmed data to reference genome (D.melanogaster release 6) using bwa 0.7.8
  - Removing all unmapped reads,reads with unmapped mates, and non-primary reads or any improperly aligned reads using samtools 1.3
  - Removing duplicated reads using picard 2.18.27
  - Keeping only reads from five major chromosome arms :X,2R,2L,3R,and 3L using samtools 1.3
  - Shifting processed reads by +4bp, and -5bp for plus strand and minus strand to produce corrected bam files
  - Converting corrected bam files to bedpe format (bed files) using bedtools 2.25.0

## Peak calling:

+ The main script is peakcalling.sh. It is used for:
  - Merging of all corrected bam files by tissues across replciates and genotypes
  - Performing peak calling using MACSs. Peaks are regions which have the highest read density compared to background reads density. Within these regions, the highest read density locus is the peak summit. The result are four ENCODE NarrowPeak format files, one for each tissue. These are tissue peak files. 
  
## Peak merging and averaging:

+ The main script is Unionpeak.sh and Union.py-a custom python script. They are used for:
  - Concatenating tissue peak files, sorting by chromosome and peak summit with
  - Grouping and averaging peak summit locations that were within 200 bp of one another, but greater than 200bp from nearest adjacent peak summit using Union.py 
  - The final merged and averaged peak file is named all tissue

## Euchromatin peak filter and peak annotation: 

+ After merging and averaging, peaks are filtered by euchromatin region shown in Supplementary Table 1 in the paper using awk. 
+ All tissue peaks are annotated using peakannotation.sh:
  - Peak annotation is done using HOMER
  - After annotation of peaks, the percentages of peaks falling into each feature types by tissue are given in Supplementary Table 2 in the paper. 
+ Randomly assigned one million peak locations are generated using genmomeartificialpeak.py to provide random distribution of percentages of peaks by feature types  

## Peak quality control plot:

+ The script to generate the peak quality control plots is peakqualityplot.r.
+ Data for the peakqualityplot.r are generated as follows:
  - The number of overlapped peaks for VennDiagram are input manually per VennDiagram documentation, and are generated via the mergePeak function in HOMER with option -venn on the HOMER bed files generated in the peak annotation step. The maximum distance between peak centers has to be equal or less than 100bp for two peaks to be considered "overlapping". The Venn diagram inputs are generated by tissueoverlapvenndiagram.sh.
  - The first peak enrichment profile that we used is the genome peak enrichment distribution profile. The second peak enrichment profile that we used is peak enrichment distribution in relation to distance to TSS. The last peak enrichment profile is peak enrichment distribution in relation to annotated feature types of the peaks. These data are generated using peakqualitydatageneration.sh.
+ Lastly, Manhattan plots are also generated for peak enrichment and the peak p-value to ensure peaks are not spatially clustered. The script to generate these Manhattan plots are peakquality.r and peakqualitydatageneration.sh.

## Normalization for differences between tissues and genotypes:

+ Weight is calculated using script fragfile1.sh, fragfile2.sh, and fragfile3.sh (if weights are calculated for fragments without SV correction, the bedtools intersect command in fragfile1.sh need to be removed). The calculation of weights are described in the paper. 
+ The calculations for coverage and fragment length are done using scripts named CLmatrix.sh and CL.py.
+ Coverage are then averaged over replicates (within tissues and genotypes), and are provided as UCSC Genome browser tracks. The tracks and their hubs are described in browsertrack.txt)

## Coverage statistical test:

+ Two ANOVA statistical tests are carried out in R using CLanova.r at peaks to identify those that differ among genotypes, tissues, or their interaction for weighted log transformed Coverage (lnC = ln(C+5)) after loci with a weighted average coverage < 50 were dropped as:
  - lnC ~ geno + tissue + geno:tissue
+ False Discovery Rates associated with the p-values from the genome scans were calculated using the p.adjust function in R. Tests with an FDR adjusted p-value < 0.005 are considered significant.
+ QQ plots and Manhattan plots were generated for the ANOVA results as described above using CLanova1.sh,CLanova2.sh and CLanovaresultplot.r.
+ We define hits unique to the SV-uncorrected dataset as false positives, and estimate the rate of such false positives in experiments that do not correct for hidden SVs.  Results are also represented as Venn diagrams using the VennDiagram package in R. 

## Causative SNP and SV identification by random effect model: 

+ For peaks with significant genotype, or genotype:tissue interaction effects (for either coverage and fragment length) we attempted to identify markers - either SNPs within 250bp or SVs within 800bp of the peak - that could potentially explain the significance. We tested significance using the following random effects model in R::lme4:
  - lnC ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker) 
+ SNPs and SVs are identified using Causativesnpsvmaster.sh, and tests carried out using lmebygroup.r.  
+ We estimate the proportion of variance explained by a marker as varm/[varm+ varg:m] or marker:tissue as varm:t/[varm:t + varg:m:t] respectively.
+ We examine the distributions of these marker tests and maintain a list of polymorphisms explaining 100% of the variation associated with peaks. We finally annotate SNPs explaining 100% variance using SnpEff [(55)] [snpEff.jar dmel_r6.31 snp.vcf.txt  > annotatedsnp.txt] and HOMER.




