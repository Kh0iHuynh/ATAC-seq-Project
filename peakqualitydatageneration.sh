#!/bin.bash


######
# echo headers for data files
######

echo "PeakScore Annotation      DistancetoTSS   Tissue" > BRpeak.txt
echo "PeakScore Annotation      DistancetoTSS   Tissue" > OVpeak.txt
echo "PeakScore Annotation      DistancetoTSS   Tissue" > EDpeak.txt
echo "PeakScore Annotation      DistancetoTSS   Tissue" > WDpeak.txt


#######
# input files are result of peak annotation using peakannotation.sh
# print peakscore (enrichment), annotation, distance to TSS, and tissue name
#######


tail -n +2 BR.peakannotation.3.txt | awk 'BEGIN{OFS=FS="\t"}{print $6,$8,$10,"BR"}' | sed 's/([^()]*)//g' | sed 's/ //g' >> BRpeak.txt

tail -n +2 OV.peakannotation.3.txt | awk 'BEGIN{OFS=FS="\t"}{print $6,$8,$10,"OV"}' | sed 's/([^()]*)//g' | sed 's/ //g' >> OVpeak.txt

tail -n +2 ED.peakannotation.3.txt | awk 'BEGIN{OFS=FS="\t"}{print $6,$8,$10,"BR"}' | sed 's/([^()]*)//g' | sed 's/ //g' >> EDpeak.txt
tail -n +2 WD.peakannotation.3.txt | awk 'BEGIN{OFS=FS="\t"}{print $6,$8,$10,"BR"}' | sed 's/([^()]*)//g' | sed 's/ //g' >> WDpeak.txt



######
# Step a: remove gene name to leave only feature type for annotation. Print only columns: annotation, distance to TSS, and tissue name 
######

sed 's/\.9//g' BRpeak.txt | sed 's/\.1//g' | sed 's/\.2//g' | sed 's/\.3//g' | sed 's/\.4//g' | sed 's/\.5//g' | sed 's/\.6//g' | sed 's/\.7//g' | sed 's/\.8//g' | sed 's/\.10//g' | sed 's/S0/S/g' | awk '{print $2,$3,$4}' >  test1.txt

sed 's/\.9//g' OVpeak.txt | sed 's/\.1//g' | sed 's/\.2//g' | sed 's/\.3//g' | sed 's/\.4//g' | sed 's/\.5//g' | sed 's/\.6//g' | sed 's/\.7//g' | sed 's/\.8//g' | sed 's/\.10//g' | sed 's/S0/S/g' | awk '{print $2,$3,$4}' > test2.txt

sed 's/\.9//g' EDpeak.txt | sed 's/\.1//g' | sed 's/\.2//g' | sed 's/\.3//g' | sed 's/\.4//g' | sed 's/\.5//g' | sed 's/\.6//g' | sed 's/\.7//g' | sed 's/\.8//g' | sed 's/\.10//g' | sed 's/S0/S/g' | awk '{print $2,$3,$4}' > test3.txt

sed 's/\.9//g' WDpeak.txt | sed 's/\.1//g' | sed 's/\.2//g' | sed 's/\.3//g' | sed 's/\.4//g' | sed 's/\.5//g' | sed 's/\.6//g' | sed 's/\.7//g' | sed 's/\.8//g' | sed 's/\.10//g' | sed 's/S0/S/g' | awk '{print $2,$3,$4}' > test4.txt

#######
# Step b: print peak enrichment column
#######

awk '{print $1}' BRpeak.txt > test5.txt

awk '{print $1}' OVpeak.txt > test6.txt

awk '{print $1}' EDpeak.txt > test7.txt

awk '{print $1}' WDpeak.txt > test8.txt

######
# paste step a and b to generate final data files for peak quality plots: enrichment vs distance to tss, and enrichment vs feature type
######
paste -d" " test5.txt test1.txt > BRheightbyfeature.txt

paste -d" " test6.txt test2.txt > OVheightbyfeature.txt

paste -d" " test7.txt test3.txt > EDheightbyfeature.txt
paste -d" " test8.txt test4.txt > WDheightbyfeature.txt

######
# peak enrichment only files. These are inputs for peak enrichment histogram
###### 

awk '{print $1}' BRpeak.txt > BRpeaks.txt

awk '{print $1}' OVpeak.txt > OVpeaks.txt

awk '{print $1}' EDpeak.txt > EDpeaks.txt

awk '{print $1}' WDpeak.txt > WDpeaks.txt


#######
# echo headers for data inputs for peak manhattan pplots
#######
echo  "chr      pos     logp    Fold"  > BRpeak.txt
echo  "chr      pos     logp    Fold"  > OVpeak.txt
echo  "chr      pos     logp    Fold"  > EDpeak.txt
echo  "chr      pos     logp    Fold"  > WDpeak.txt

#######
# print approriate columns:chromosome,position of peak, logp, fold enrichment from peak files for each tissue
# the output files are data input for peak manhattan plot
#######
awk 'BEGIN{OFS=FS="\t"} {if($8 >=2) print $1,$2 + $10, $8, $7}' ../onlyeu.BR_peaks.narrowPeak >> BRpeak.txt

awk 'BEGIN{OFS=FS="\t"} {if($8 >=2) print $1,$2 + $10,$8, $7}' ../onlyeu.OV_peaks.narrowPeak >> OVpeak.txt
awk 'BEGIN{OFS=FS="\t"} {if($8 >=2) print $1,$2 + $10,$8 ,$7}' ../onlyeu.ED_peaks.narrowPeak >> EDpeak.txt
awk 'BEGIN{OFS=FS="\t"} {if($8 >=2) print $1,$2 + $10, $8, $7}' ../onlyeu.WD_peaks.narrowPeak >> WDpeak.txt
