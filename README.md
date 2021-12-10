# **ATAC-seq Project:**

## Raw sequence data processing. 

+ The main script is bamprocess.sh used for:
  -Trimming of the adapter from raw data using Trimgalore-0.4.5
  -Aligning trimmed data to reference genome (D.melanogaster release 6) using bwa 0.7.8
  -Removing all unmapped reads,reads with unmapped mates, and non-primary reads or any improperly aligned reads using samtools 1.3
  -Removing duplicated reads using picard 2.18.27
  -Keeping only reads from five major chromosome arms :X,2R,2L,3R,and 3L using samtools 1.3
  -Shifting processed reads by +4bp, and -5bp for plus strand and minus strand to produce corrected bam files
  -Converting corrected bam files to bedpe format (bed files) using bedtools 2.25.0

## Peak calling:

The main script is peakcalling.sh. It calls for regions which have the highest read density compared to background reads density. Within these regions, the highest read density locus is the peak summit.

## Peak merging and averaging:

The main script is averagepeak.sh. This script takes in all peak files called for each tissues (4 tissues total). Then, it process the script accodring to the averaging method in the paper. 

## Euchromatin peak filter and peak annotation: 

The main script is peakannotation.sh. It is used to annotated the peaks that are filtered using the euchromatin boundaries described in the paper. 

## Peak quality control plot:

The main script is peakqualityplot.r. The script will output all of the peak quality control plots in the paper. The inputs for the script are generated by peakqualitydatageneration.sh

## Normalization for differences between genotypes and tissues for all samples:

The main scripts are fragfile1.sh, fragfile2.sh, and fragfile3.sh . These are used to calculate for weights for each fragment lengths after removal of SV spanning fragments. If weights are calculated for all fragments, the bedtools intersect command in fragfile1.sh need to be removed. This command is used to remove all SV spanning fragments. 

## C and L matrix calculation:

The main scripts are CLmatrix.sh and CL.py. The CLmatrix.sh is the script that process fragment files and calculate for C and L by locus using the CL.py script. The model for C and L are:

a/ Ci = sum(Wi)
b/ Li = sum(Wi * FLi )/ sum(Wi)

Ci stands for C value at position i. Wi stands for weight at position i. FLi is the fragment lenght at position i and its weight Wi. 

## C and L matrices statistical test:

The main scripts are CLanova1.sh, CLanova2.sh, CLanova.r



