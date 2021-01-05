#!/bin/bash/

######
# print
######
sort snpcovint.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > temp1.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete1.txt note.txt | sed 's/\t/ /g' > notesnpcovint.txt


sort snpcovgeno.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > temp2.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete2.txt note.txt | sed 's/\t/ /g' > notesnpcovgeno.txt




sort SVcovint.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > temp3.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete3.txt note.txt | sed 's/\t/ /g' > noteSVcovint.txt


sort SVcovgeno.txt | uniq -c | awk '{ print $2,$3}' | sed 's/ /\t/g' > temp4.txt
awk 'FNR==NR{a[$1] =$1;b[$2]= $2;next}($1 in a) && ($2 in b){ print $0;}' delete4.txt note.txt | sed 's/\t/ /g' > noteSVcovgeno.txt




python Coverageindex.py
