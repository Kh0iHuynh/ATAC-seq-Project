#!/bin/bash


files="list.txt"
# I gave you a tar of this directoryref="/bio/khoih/ref/dm6.fa"
cut -f10-24 DSPR.r6.SNPs.vcf > delete1.txt

for i in `seq 1 1 15`
do
rawfix=`head -n $i $files | tail -n 1`
cut -f$i delete1.txt | sed -E 's/\/.*//g' > temp.$i.txt
awk -v geno=$rawfix 'BEGIN{OFS=FS="\t"}{print $1,$2,geno,$5}' DSPR.r6.SNPs.vcf > temp2.$i.txt
paste temp2.$i.txt temp.$i.txt > all.$i.txt

done

cat all.*.txt > delete3.txt


#snp.txt is a file with chr position strain genotype snpstatus.
# for snpstatus: 0 mean no,1 mean yes, . is undetermined
grep -v "POS" delete3.txt | awk 'BEGIN{OFS=FS"\t"}{if($5 == "0") print $1,$2,$3,$4="R",$5; else if ($5 != "0") print $1,$2,$3,$4,$5}' - > snp.txt


awk 'BEGIN{OFS=FS="\t"}{print $1,$2}' snp.txt |sort |uniq -c | awk 'BEGIN{OFS=FS="\t"}{print $2,$3}' > snppos.bed



files="list.txt"
# I gave you a tar of this directoryref="/bio/khoih/ref/dm6.fa"
cut -f10-24 SV.0328.vcf > delete1.txt

for i in `seq 1 1 15`
do
rawfix=`head -n $i $files | tail -n 1`
cut -f$i delete1.txt | sed -E 's/\/.*//g' > temp.$i.txt
awk -v geno=$rawfix 'BEGIN{OFS=FS="\t"}{print $1,$2,geno,$8}' SV.0328.vcf | sed 's/FL=//g' > temp2.$i.txt
cut -d";" -f1 temp2.$i.txt > temp3.$i.txt
paste temp3.$i.txt temp.$i.txt > all.$i.txt

done

cat all.*.txt > delete3.txt


# SV.txt is file with chr pos strain typeofSV SVstatus.
#For SVstatus: 0 mean no,1 mean yes, . is undetermined


grep -v "POS" delete3.txt | awk 'BEGIN{OFS=FS"\t"}{if($5 == "0") print $1,$2,$3,$4="R",$5; else if ($5 != "0") print $1,$2,$3,$4,$5}' > SV.txt

awk 'BEGIN{OFS=FS="\t"}{print $1,$2}' SV.txt |sort |uniq -c | awk 'BEGIN{OFS=FS="\t"}{print $2,$3}' > SVpos.bed
