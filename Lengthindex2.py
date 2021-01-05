
import os
if os.path.exists("slg.txt"):
  os.remove("slg.txt")
else:
  print("The file does not exist")


file2 = open('temp2.txt', 'r')
Lines2 = file2.readlines()

##peak file that has snp,SV close
file3 = open('notesnplengeno.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min and lines2.split()[2] == lines3.split()[4]:
                        f = open('slg2.txt', 'a')
                        print(lines3.split()[0],lines3.split()[1],lines2.split()[1],lines3.split()[3],lines3.split()[4],lines3.split()[5],lines3.split()[6],lines2.split()[3],sep ="\t" ,file=f)
                        f.close()


import os
if os.path.exists("sli.txt"):
  os.remove("sli.txt")
else:
  print("The file does not exist")

file2 = open('temp1.txt', 'r')
Lines2 = file2.readlines()

##peak file that has snp,SV close
file3 = open('notesnplenint.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min and lines2.split()[2] == lines3.split()[4]:
                        f = open('sli2.txt', 'a')
                        print(lines3.split()[0],lines3.split()[1],lines2.split()[1],lines3.split()[3],lines3.split()[4],lines3.split()[5],lines3.split()[6],lines2.split()[3],sep ="\t" ,file=f)
                        f.close()

import os
if os.path.exists("svlg.txt"):
  os.remove("svlg.txt")
else:
  print("The file does not exist")


file2 = open('temp4.txt', 'r')
Lines2 = file2.readlines()

##peak file that has SV,SV close
file3 = open('noteSVlengeno.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min and lines2.split()[2] == lines3.split()[4]:
                        f = open('svlg2.txt', 'a')
                        print(lines3.split()[0],lines3.split()[1],lines2.split()[1],lines3.split()[3],lines3.split()[4],lines3.split()[5],lines3.split()[6],lines2.split()[3],sep ="\t" ,file=f)
                        f.close()


import os
if os.path.exists("svli.txt"):
  os.remove("svli.txt")
else:
  print("The file does not exist")


file2 = open('temp3.txt', 'r')
Lines2 = file2.readlines()

##peak file that has SV,SV close
file3 = open('noteSVlenint.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min and lines2.split()[2] == lines3.split()[4]:
                        f = open('svli2.txt', 'a')
                        print(lines3.split()[0],lines3.split()[1],lines2.split()[1],lines3.split()[3],lines3.split()[4],lines3.split()[5],lines3.split()[6],lines2.split()[3],sep ="\t" ,file=f)
                        f.close()
