from collections import defaultdict
from pybedtools import BedTool
import math
import glob
import os
import argparse

SW = defaultdict(lambda : defaultdict(dict))
SWL = defaultdict(lambda : defaultdict(dict))
SWMD = defaultdict(lambda : defaultdict(dict))
SWMD2 = defaultdict(lambda : defaultdict(dict))


parser = argparse.ArgumentParser()
parser.add_argument('-b','--filename', type=str, help = "inputbed")
parser.add_argument('-f','--weightfile', type=str, help = "inputfilename")

args = parser.parse_args()

# REference peak file
# chr start stop  (step is 1 between start,stop)

peakfile = args.filename + ".bed"
peaks=BedTool(peakfile)

# the program is currently hardwired to look at all the files ending in
#  ".withweight.txt" in the directory fragfiles
#  is could clearly be changed
#  each file is a "bed" ... so must be tab delimited.


# the following is fragment file intersect with peakfile above:
weight_file ="./"+ args.weightfile + ".withweight.txt"



listOfFiles = glob.glob(weight_file)
for file in listOfFiles:
        temp = os.path.splitext(os.path.basename(file))[0]
        short = temp.replace("Sample_", "").replace(".withweight","")
        # initialize the counters
        for i in peaks:
                chr=i[0]
                pos=i[1]
                SW[short][chr][pos] = 0
                SWL[short][chr][pos] = 0

        frgpeak = open(weight_file)

        #chr3L  5610755 5610905 150     1.0647  chr3L   5610793 5610794
        for line in frgpeak:
                i = line.split()
                chr = i[5]
                pos = i[6]
                mw = float(i[4])
                ml = float(i[3])
                SW[short][chr][pos] += mw
                SWL[short][chr][pos] += mw*ml
# done building hash, now print out

allSample = SW.keys()

allChr = SW[allSample[0]].keys()

fileC = open("./" + args.weightfile + "/matrix.C.txt","w")
fileL = open("./" + args.weightfile +"/matrix.L.txt","w")


# headers
fileC.write("chr\tpos")
fileL.write("chr\tpos")
for s in allSample:
        fileC.write("\t"+s)
        fileL.write("\t"+s)
fileC.write("\n")
fileL.write("\n")


for c in allChr:
        temp=SW[allSample[0]][c].keys()
        allPos = sorted(temp,key=int)
        for p in allPos:
                fileC.write(c + "\t" + p)
                fileL.write(c + "\t" + p)

                for s in allSample:
                        if not(p in SW[s][c]) or SW[s][c][p] == 0:
                                fileC.write("\t0")
                                fileL.write("\tNA")
                        else:
                                fileC.write("\t" + str(SW[s][c][p]))
                                fileL.write("\t" + str(SWL[s][c][p]/SW[s][c][p]))
                fileC.write("\n")
                fileL.write("\n")
fileC.close()
fileL.close()
