#!/bin/bash/

##################################

module load samtools
module load bwa
module load bedtools

# created a 30 kb fasta file from the hairy region = dmelwo.fa
# inserted a 25000 kb transposon element in the middle of the 30 kb region (@ 14400) = dmelTE.fa
# insert.bed is the location of the SV, so it has a single line = dm6wo 14399   14401

# index

bwa index dmelwo.fa

bwa index dmelTE.fa

samtools faidx dmelwo.fa

samtools faidx dmelTE.fa

# simulate reads, note:
#    1.  the numbers are proportional to sequence length
#    2.  assume 400 average length, with 100bp sd, not sure what real lengths look like
wgsim -1 50 -2 50 -N 325000 -r 0 -R 0 -X 0 -e 0 -d 400 -s 100 -S 50 dmelTE.fa dmelTE.F.fq dmelTE.R.fq
wgsim -1 50 -2 50 -N 300000 -r 0 -R 0 -X 0 -e 0 -d 400 -s 100 -S 50 dmelwo.fa dmelwo.F.fq dmelwo.R.fq

# align reads to reference, keep q 30 alignment with both reads mapping, calculate physical coverage of region
# also calculate coverage after correction
bwa mem dmelwo.fa dmelwo.F.fq dmelwo.R.fq | samtools view -q30 -bS - | samtools view -bf 0x2 - | bamToBed -i stdin -bedpe | cut -f 1,2,6 > frags.wo.txt
cat frags.wo.txt | bedtools genomecov -i stdin -g dmelwo.fa.fai -d > wo.cov.txt
cat frags.wo.txt | bedtools subtract -a stdin -b insert.bed -A | bedtools genomecov -i stdin -g dmelwo.fa.fai -d > wo.ccov.txt

bwa mem dmelwo.fa dmelTE.F.fq dmelTE.R.fq | samtools view -q30 -bS - | samtools view -bf 0x2 - | bamToBed -i stdin -bedpe | cut -f 1,2,6 > frags.TE.txt
cat frags.TE.txt | bedtools genomecov -i stdin -g dmelwo.fa.fai -d > TE.cov.txt
cat frags.TE.txt | bedtools subtract -a stdin -b insert.bed -A | bedtools genomecov -i stdin -g dmelwo.fa.fai -d > TE.ccov.txt


