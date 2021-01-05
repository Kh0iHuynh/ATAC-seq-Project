#!/bin/bash/

######
# Coverage
######
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
# Length
######

sort snplenint.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > delete1.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete1.txt note.txt | sed 's/\t/ /g' > notesnplenint.txt


sort snplengeno.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > delete2.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete2.txt note.txt | sed 's/\t/ /g' > notesnplengeno.txt




sort SVlenint.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > delete3.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete3.txt note.txt | sed 's/\t/ /g' > noteSVlenint.txt


sort SVlengeno.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > delete4.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete4.txt note.txt | sed 's/\t/ /g' > noteSVlengeno.txt

python Lengthindex1.py
python Lengthindex2.py


######
# Removed dupplicated position due to snp data in AB8 genotype
######



#!/bin/bash


echo "chr peak_pos marker_pos coverage geno tis rep marker" > scg.txt
echo "chr peak_pos marker_pos coverage geno tis rep marker" > sci.txt
#echo "chr peak_pos marker_pos coverage geno tis rep marker" > svcg.txt
#echo "chr peak_pos marker_pos coverage geno tis rep marker" > svci.txt


echo "chr peak_pos marker_pos length geno tis rep marker" > slg.txt
echo "chr peak_pos marker_pos length geno tis rep marker" > sli.txt
#echo "chr peak_pos marker_pos length geno tis rep marker" > svlg.txt
#echo "chr peak_pos marker_pos length geno tis rep marker" > svli.txt


sort coverage/scg.txt | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sort -k1,1 -k2,2n -k3,3n -k5,5 -k6,6 -k7,7n >> scg.txt
sort coverage/sci.txt | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sort -k1,1 -k2,2n -k3,3n -k5,5 -k6,6 -k7,7n >> sci.txt
sort coverage/svcg.txt | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sort -k1,1 -k2,2n -k3,3n -k5,5 -k6,6 -k7,7n > svcg.txt
sort coverage/svci.txt | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sort -k1,1 -k2,2n -k3,3n -k5,5 -k6,6 -k7,7n > svci.txt

sort length/svli.txt | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sort -k1,1 -k2,2n -k3,3n -k5,5 -k6,6 -k7,7n > svli.txt
sort length/svlg.txt | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sort -k1,1 -k2,2n -k3,3n -k5,5 -k6,6 -k7,7n > svlg.txt
sort length/sli.txt | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sort -k1,1 -k2,2n -k3,3n -k5,5 -k6,6 -k7,7n >> sli.txt
sort length/slg.txt | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sort -k1,1 -k2,2n -k3,3n -k5,5 -k6,6 -k7,7n >> slg.txt

rm tempsvli.txt
rm tempsvlg.txt
rm tempsvci.txt
rm tempsvcg.txt
python whatever.py


echo "chr peak_pos marker_pos coverage geno tis rep marker" > svcg.txt
echo "chr peak_pos marker_pos coverage geno tis rep marker" > svci.txt
echo "chr peak_pos marker_pos length geno tis rep marker" > svlg.txt
echo "chr peak_pos marker_pos length geno tis rep marker" > svli.txt

sed '/^[[:space:]]*$/d' tempsvli.txt | sed 's/\t/ /g' | sed 's/R , //g' | sed 's/ , R//g' | cut -d":" -f1 | sort -k5,5 -k6,6 -k7,7 -k1,1 -k2,2n -k3,3n | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | cut -d":" -f1 >> svli.txt

sed '/^[[:space:]]*$/d' tempsvlg.txt | sed 's/\t/ /g' | sed 's/R , //g' | sed 's/ , R//g' | cut -d":" -f1 | sort -k5,5 -k6,6 -k7,7 -k1,1 -k2,2n -k3,3n | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | cut -d":" -f1 >> svlg.txt

sed '/^[[:space:]]*$/d' tempsvcg.txt | sed 's/\t/ /g' | sed 's/R , //g' | sed 's/ , R//g' | cut -d":" -f1 | sort -k5,5 -k6,6 -k7,7 -k1,1 -k2,2n -k3,3n | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | cut -d":" -f1 >> svcg.txt


sed '/^[[:space:]]*$/d' tempsvci.txt | sed 's/\t/ /g' | sed 's/R , //g' | sed 's/ , R//g' | cut -d":" -f1 | sort -k5,5 -k6,6 -k7,7 -k1,1 -k2,2n -k3,3n | uniq -c | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | cut -d":" -f1 >> svci.txt


