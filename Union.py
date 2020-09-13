from collections import defaultdict
import math
import glob
import os
import argparse
import sys


#start last line as variable:
last = None
# start list for chr,start,end,summit
chromosome = []
peakstart = []
peakend = []
summit = []
#########
# add new line at the end of file
# to by pass looping over last line of file
#########
new_line = "0 0 0 0\n"
with open("peak.txt", "a") as a_file:
  a_file.write(new_line)

##############
f = open("peak.txt","r")
for line in f.readlines():
        if last is not None:
                # fine here
                diff = int(line.split()[3]) - int(last.split()[3])
                if abs(diff) < 500:
                        peakstart.append(int(last.split()[1]))
                        peakend.append(int(last.split()[2]))
                        summit.append(int(last.split()[3]))
                        chromosome.append(last.split()[0])
                else:
                        peakstart.append(int(last.split()[1]))
                        peakend.append(int(last.split()[2]))
                        summit.append(int(last.split()[3]))
                        chromosome.append(last.split()[0])
                        left = min(peakstart)
                        right = max(peakend)
                        avgsummit = sum(summit)/len(summit)
                        with open('unionpeak.txt', 'a') as union:
                                print(last.split()[0],left,right,round(avgsummit),file=union)

                        chromosome[:] = []
                        summit[:] = []
                        peakstart[:] = []
                        peakend[:] = []
        last = line

