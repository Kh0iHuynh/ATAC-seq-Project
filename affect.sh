#!/bin/bash


files="filelist.txt"
# I gave you a tar of this directoryref="/bio/khoih/ref/dm6.fa"




for i in {1..294}
do
        rawfix=`head -n $i $files | tail -n 1`
        echo '
# mean covearge for each genotype and tissue combination
file2 = open("samplemean.txt","r")
Lines2 = file2.readlines()

##peak file with mean coverage for each peak
file3 = open("basemean.txt", "r")
Lines3 = file3.readlines()

#list of marker to peak with percent

file4 = open("'$rawfix'", "r")
Lines4 = file4.readlines()


file5 = open("SVSNP.txt", "r")
Lines5 = file5.readlines()




for lines4 in Lines4:
 for lines5 in Lines5:
  if lines5.split()[0] == lines4.split()[0] and int(lines5.split()[1]) == int(lines4.split()[2]):
   f = open("'$rawfix.1.txt'", "a")
   print(lines4.split()[0],lines4.split()[1],lines4.split()[2],lines4.split()[3],lines4.split()[4],lines5.split()[2], lines5.split()[5],sep ="\t" ,file=f)
   f.close()




file6 = open("'$rawfix.1.txt'", "r")
Lines6 = file6.readlines()

####
# compare the coverage to base coverage and call for gain of fucntion or loss of function
####
for lines6 in Lines6:
 for lines2 in Lines2:
  for lines3 in Lines3:
   if lines2.split()[0] == lines6.split()[0] and lines6.split()[5] == lines2.split()[2] and lines2.split()[1] == lines6.split()[1] and lines3.split()[0] == lines6.split()[0] and lines3.split()[1] == lines6.split()[1] and int(lines2.split()[4]) > int(lines3.split()[2]):
    f1 = open("'Gain.$rawfix.txt'", "a")
    print(lines6.split()[0],lines6.split()[1],lines6.split()[2],lines6.split()[3],lines6.split()[4],lines6.split()[5],lines6.split()[6],lines2.split()[3],"Gain",sep = "\t",file =f1)
    f1.close()
   if lines2.split()[0] == lines6.split()[0] and lines6.split()[5] == lines2.split()[2] and lines2.split()[1] == lines6.split()[1] and lines3.split()[0] == lines6.split()[0] and lines3.split()[1] == lines6.split()[1] and int(lines2.split()[4]) < int(lines3.split()[2]):
    f2 = open("'Loss.$rawfix.txt'", "a")
    print(lines6.split()[0],lines6.split()[1],lines6.split()[2],lines6.split()[3],lines6.split()[4],lines6.split()[5],lines6.split()[6],lines2.split()[3],"Loss",sep = "\t",file =f2)
    f2.close()


' > $rawfix.py
        echo '#!/bin/bash

#SBATCH --job-name='$rawfix'     ## Name of the job.     ## account to charge
#SBATCH -A khoih
#SBATCH -p free          ## partition/queue name
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=1    ## number of cores the job needs
#SBATCH --error=slurm-%J.err ## error log file

module load R/3.6.2
module load python/3.8.0
python '$rawfix.py'
' > $rawfix.sub
        sbatch $rawfix.sub
        sleep 5
done
