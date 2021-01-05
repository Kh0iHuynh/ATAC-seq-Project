
file2 = open('snp.txt', 'r')
Lines2 = file2.readlines()

##peak file that has snp,SV close
file3 = open('delete1.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min:
                        f = open('temp1.txt', 'a')
                        print(lines2.split()[0],lines2.split()[1],lines2.split()[2],lines2.split()[3],lines2.split()[4],sep ="\t" ,file=f)
                        f.close()

import os
if os.path.exists("temp2.txt"):
  os.remove("temp2.txt")
else:
  print("The file does not exist")

file2 = open('snp.txt', 'r')
Lines2 = file2.readlines()

##peak file that has snp,SV close
file3 = open('delete2.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min:
                        f = open('temp2.txt', 'a')
                        print(lines2.split()[0],lines2.split()[1],lines2.split()[2],lines2.split()[3],lines2.split()[4],sep ="\t" ,file=f)
                        f.close()

import os
if os.path.exists("temp3.txt"):
  os.remove("temp3.txt")
else:
  print("The file does not exist")


file2 = open('SV.txt', 'r')
Lines2 = file2.readlines()

##peak file that has snp,SV close
file3 = open('delete3.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min:
                        f = open('temp3.txt', 'a')
                        print(lines2.split()[0],lines2.split()[1],lines2.split()[2],lines2.split()[3],lines2.split()[4],sep ="\t" ,file=f)
                        f.close()



import os
if os.path.exists("temp4.txt"):
  os.remove("temp4.txt")
else:
  print("The file does not exist")


file2 = open('SV.txt', 'r')
Lines2 = file2.readlines()

##peak file that has snp,SV close
file3 = open('delete4.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min:
                        f = open('temp4.txt', 'a')
                        print(lines2.split()[0],lines2.split()[1],lines2.split()[2],lines2.split()[3],lines2.split()[4],sep ="\t" ,file=f)
                        f.close()

