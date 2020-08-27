#!/bin/bash
#$ -N ATACseq
#$ -q adl,bio,pub64,pub8i,free64,free16i,free48,free32i,free88i
#$ -pe openmp 4
#$ -R y
#$ -t 1-96



module load enthought_python/7.3.2
module load bwa/0.7.8
module load samtools/1.3
module load bcftools/1.3
module load gatk/2.4-7
module load picard-tools/1.87
module load java/1.7
module load bedtools/2.25.0
module load java
module load bowtie2/2.2.7
module load R/3.4.1


#downsample=1
#alignment=2
#faq main directory = 3
#numberof downsample = 4
#core number = 5
#total number of tasks = 6


# name.txt contains all file name without extension:
files="$fqdir/name.txt"
ref="$fqdir/ref/dm6.fa"
# I gave you a tar of this directoryref="/bio/khoih/ref/dm6.fa"
rawfix=`head -n $SGE_TASK_ID $files | tail -n 1`

downsample=$1
alignment=$2
fqdir=$3
downread=$4
bwacore=$5
task=$6

a=`ls $fqdir/$rawfix/*_R1*.fq.gz | tr 'n' ' '`
b=`ls $fqdir/$rawfix/*_R2*.fq.gz | tr 'n' ' '`

bwa mem -t $bwacore -M $ref <(zcat $a) <(zcat $b) | samtools view -bS - > $fqdir/$rawfix.bam
# =============================
# Remove unmapped, mate unmapped
# not primary alignment, reads failing platform
# Only keep properly paired reads
# Obtain name sorted BAM file
# ==================
samtools view -F 524 -f 2 -u $fqdir/$rawfix.bam > $fqdir/$rawfix.2.bam
samtools sort -n $fqdir/$rawfix.2.bam -o $fqdir/$rawfix.sorted.bam
samtools index $fqdir/$rawfix.sorted.bam
echo "ready for fixmate"
#===================================
# Remove orphan reads (pair was removed)
# and read pairs mapping to different chromosomes
# Obtain position sorted BAM
#====================================
samtools fixmate -r $fqdir/$rawfix.sorted.bam $fqdir/$rawfix.fixmate.bam
samtools view -F 1804 -f 2 -u $fqdir/$rawfix.fixmate.bam > $fqdir/$rawfix.fixmate.temp.bam
samtools sort $fqdir/$rawfix.fixmate.temp.bam -o $fqdir/$rawfix.fixmate.sort.bam
samtools index $fqdir/$rawfix.fixmate.sort.bam
echo "fixmate done"
# =============
# Mark duplicates
# =============
java -jar /bio/khoih/picard_2_18_7.jar MarkDuplicates I=$fqdir/$rawfix.fixmate.sort.bam O=$fqdir/$rawfix.dedup.bam M=$fqdir/$rawfix.dups.txt REMOVE_DUPLICATES=true
#===========
# REMOVE MITO
#=============
samtools sort $fqdir/$rawfix.dedup.bam -o $fqdir/$rawfix.dedup.sort.bam
samtools index $fqdir/$rawfix.dedup.sort.bam
samtools view -b $fqdir/$rawfix.dedup.sort.bam chrX chr2L chr2R chr3L chr3R > $fqdir/$rawfix.nomt.bam
samtools sort -n $fqdir/$rawfix.nomt.bam -o $fqdir/$rawfix.nomtsort.bam

#=============
# shifting reads in bam files directly
#===========

samtools view -h $fqdir/$rawfix.nomtsort.bam | awk -F $'\t' 'BEGIN {OFS = FS}{ if($9 > 0) print $1, $2, $3, $4+4, $5, $6, $7, $8+4, $9, $10, $11, $12, $13, $14, $15, $16, $17; else print $1, $2, $3, $4-5, $5, $6, $7, $8-5, $9, $10, $11, $12, $13, $14, $15, $16, $17;}' | samtools view -bSh > $fqdir/${rawfix}.corrected.bam


#================
# convert bam to bedpe file
#================
bedtools bamtobed -bedpe -mate1 -i $fqdir/$rawfix.nomtsort.bam  | awk -F $'\t' 'BEGIN {OFS = FS}{ if ($9 == "+") {$2 = $2 + 4} else if ($9 == "-") {$3 = $3 - 5} print $0}'  | awk -F $'\t' 'BEGIN {OFS = FS}{ if ($10 == "+") {$5 = $5 + 4} else if ($10 == "-") {$6 = $6 - 5} print $0}'  > $fqdir/$rawfix.shifted.bed
