#!/bin/bash

#SBATCH --job-name=TECL      ## Name of the job.
#SBATCH -A khoih     ## account to charge
#SBATCH -p free        ## partition/queue name
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=4    ## number of cores the job needs
#SBATCH --error=error_%A_%a.txt ## error log file
#SBATCH --array=1-32
module load ucsc-tools/v393
module load R/3.6.2
module load python/3.8.0
module load bedtools2

newdata="/dfs5/bio/khoih/backup"
# the folders...with the data
files="./listname.txt"
# I gave you a tar of this directoryref="/bio/khoih/ref/dm6.fa"
name=`head -n $SLURM_ARRAY_TASK_ID $files | tail -n 1`

#### Calculate mean coverage

echo "chr pos rep1 rep2 rep3" | sed 's/ /\t/g' > ${name}.testc.txt
paste ${name}*/matrix.C.txt | awk '{print $1,$2,$3,$6,$9}' | grep -e "pos" -v | sed 's/ /\t/g' >> ${name}.testc.txt

echo '
mydata <- read.table("'${name}.testc.txt'", header = TRUE, sep = "\t")
str(mydata)
norm <- rowMeans(mydata[,3:5])
write.table(norm, file="'${name}.meanc.txt'",row.names=FALSE)' > $name.c.r

Rscript $name.c.r
### Generate track bw
paste ${name}.testc.txt ${name}.meanc.txt > ${name}.temp2c.txt
awk '{print $1,$2,$2 +1,$6}' ${name}.temp2c.txt | grep -e "pos" -v | sed 's/ /\t/g' | sort -k1,1 -k2,2n > ${name}.covc
mkdir meanc
bedGraphToBigWig ${name}.covc /dfs5/bio/khoih/kent/dm6.len meanc/${name}.bw
