#!/bin/bash
#$ -N cov1
#$ -q pub8i
#$ -pe openmp 8
#$ -R y
#$ -t 1-1
#$ -ckpt blcr

bash extractsnpandsv.sh
awk '{print $1,$2+1}' cg.txt > covgeno.txt

awk '{print $1,$2+1}' ci.txt > covint.txt

######
# Generate peak postions that have snp or SV within 250bp
######
python cov.py

sort snpcovint.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > delete1.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete1.txt note.txt | sed 's/\t/ /g' > notesnpcovint.txt
sort snpcovgeno.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > delete2.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete2.txt note.txt | sed 's/\t/ /g' > notesnpcovgeno.txt
sort SVcovint.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > delete3.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete3.txt note.txt | sed 's/\t/ /g' > noteSVcovint.txt
sort SVcovgeno.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > delete4.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete4.txt note.txt | sed 's/\t/ /g' > noteSVcovgeno.txt

python Coverageindex1.py

python Coverageindex2.py


######
# Fragment length
######
awk '{print $1,$2+1}' cg2.txt > lengeno.txt

awk '{print $1,$2+1}' ci2.txt > lenint.txt

python len.py


python Lengthindex1.py
python Lengthindex2.py

