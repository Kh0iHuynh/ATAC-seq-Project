# **ATAC-seq Project:**

## Raw sequence data processing. 

+ The main script is bamprocess.sh. It is used for:
  - Trimming of the adapter from raw data using Trimgalore-0.4.5
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

## Normalization for differences between genotypes and tissues for all samples:

The main scripts are fragfile1.sh, fragfile2.sh, and fragfile3.sh . These are used to calculate for weights for each fragment lengths after removal of SV spanning fragments. If weights are calculated for all fragments, the bedtools intersect command in fragfile1.sh need to be removed. This command is used to remove all SV spanning fragments. 

## C and L matrix calculation:

The main scripts are CLmatrix.sh and CL.py. The CLmatrix.sh is the script that process fragment files and calculate for C and L by locus using the CL.py script. The model for C and L are:

a/ Ci = sum(Wi)
b/ Li = sum(Wi * FLi )/ sum(Wi)

Ci stands for C value at position i. Wi stands for weight at position i. FLi is the fragment lenght at position i and its weight Wi. 

## C and L matrices statistical test:

The main scripts are CLanova1.sh, CLanova2.sh, CLanova.r



