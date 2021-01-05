import os
if os.path.exists("scg.txt"):
  os.remove("scg.txt")
else:
  print("The file does not exist")


file2 = open('temp2.txt', 'r')
Lines2 = file2.readlines()


file3 = open('notesnpcovgeno.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min and lines2.split()[2] == lines3.split()[4]:
                        f = open('scg.txt', 'a')
                        print(lines3.split()[0],lines3.split()[1],lines2.split()[1],lines3.split()[2],lines3.split()[4],lines3.split()[5],lines3.split()[6],lines2.split()[3],sep ="\t" ,file=f)
                        f.close()


if os.path.exists("sci.txt"):
  os.remove("sci.txt")
else:
  print("The file does not exist")




file2 = open('temp1.txt', 'r')
Lines2 = file2.readlines()


file3 = open('notesnpcovint.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min and lines2.split()[2] == lines3.split()[4]:
                        f = open('sci.txt', 'a')
                        print(lines3.split()[0],lines3.split()[1],lines2.split()[1],lines3.split()[2],lines3.split()[4],lines3.split()[5],lines3.split()[6],lines2.split()[3],sep ="\t" ,file=f)
                        f.close()


if os.path.exists("svcg.txt"):
  os.remove("svcg.txt")
else:
  print("The file does not exist")





file2 = open('temp4.txt', 'r')
Lines2 = file2.readlines()

##peak file that has SV,SV close
file3 = open('noteSVcovgeno.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min and lines2.split()[2] == lines3.split()[4]:
                        f = open('svcg.txt', 'a')
                        print(lines3.split()[0],lines3.split()[1],lines2.split()[1],lines3.split()[2],lines3.split()[4],lines3.split()[5],lines3.split()[6],lines2.split()[3],sep ="\t" ,file=f)
                        f.close()


if os.path.exists("svci.txt"):
  os.remove("svci.txt")
else:
  print("The file does not exist")




file2 = open('temp3.txt', 'r')
Lines2 = file2.readlines()

##peak file that has SV,SV close
file3 = open('noteSVcovint.txt', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:
        max = int(lines3.split()[1]) + 250
        min = int(lines3.split()[1]) - 250
        for lines2 in Lines2:
                if lines2.split()[0] == lines3.split()[0] and int(lines2.split()[1]) < max and int(lines2.split()[1]) > min and lines2.split()[2] == lines3.split()[4]:
                        f = open('svci.txt', 'a')
                        print(lines3.split()[0],lines3.split()[1],lines2.split()[1],lines3.split()[2],lines3.split()[4],lines3.split()[5],lines3.split()[6],lines2.split()[3],sep ="\t" ,file=f)
                        f.close()

