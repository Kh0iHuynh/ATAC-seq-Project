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

