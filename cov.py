file1 = open('SVpos.bed', 'r') 
Lines1 = file1.readlines() 

file2 = open('covint.txt', 'r')
Lines2 = file2.readlines()

for lines1 in Lines1: 
	
	for lines2 in Lines2:
		max = int(lines2.split()[1]) + 250
		min = int(lines2.split()[1]) - 250
		if lines2.split()[0] == lines1.split()[0] and int(lines1.split()[1]) < max and int(lines1.split()[1]) > min:
			file1 = open('SVcovint.txt', 'a')
			file1.write(lines2)
			file1.close()



file3 = open('snppos.bed', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:

	for lines2 in Lines2:
		max = int(lines2.split()[1]) + 250
		min = int(lines2.split()[1]) - 250
		if lines2.split()[0] == lines3.split()[0] and int(lines3.split()[1]) < max and int(lines3.split()[1]) > min:
			file9 = open('snpcovint.txt', 'a')
			file9.write(lines2)
			file9.close()
 
	
file1 = open('SVpos.bed', 'r') 
Lines1 = file1.readlines() 

file2 = open('covgeno.txt', 'r')
Lines2 = file2.readlines()

for lines1 in Lines1: 
	
	for lines2 in Lines2:
		max = int(lines2.split()[1]) + 250
		min = int(lines2.split()[1]) - 250
		if lines2.split()[0] == lines1.split()[0] and int(lines1.split()[1]) < max and int(lines1.split()[1]) > min:
			file9 = open('SVcovgeno.txt', 'a')
			file9.write(lines2)
			file9.close()



file3 = open('snppos.bed', 'r')
Lines3 = file3.readlines()


for lines3 in Lines3:

	for lines2 in Lines2:
		max = int(lines2.split()[1]) + 250
		min = int(lines2.split()[1]) - 250
		if lines2.split()[0] == lines3.split()[0] and int(lines3.split()[1]) < max and int(lines3.split()[1]) > min:
			file9 = open('snpcovgeno.txt', 'a')
			file9.write(lines2)
			file9.close()
 
	
