
with open("svlg2.txt", 'r') as f:
        previous = None
        for line in f:
                if previous is not None:
                        if line.split()[0] == previous.split()[0] and line.split()[1] == previous.split()[1] and line.split()[2] == previous.split()[2] and line.split()[4] == previous.split()[4] and line.split()[5] == previous.split()[5] and line.split()[6] == previous.split()[6]:
                                final = open('tempsvlg.txt', 'a')
                                print(line.split()[0],line.split()[1],line.split()[2],line.split()[3],line.split()[4],line.split()[5],line.split()[6],line.split()[7],",",previous.split()[7],sep ="\t" ,file=final)
                                final.close()
                        else:
                                final = open('tempsvlg.txt', 'a')
                                print(line, sep = "\t",file = final)
                                final.close()
                if previous is None:
                        final = open('tempsvlg.txt', 'a')
                        print(line, sep = "\t",file = final)
                        final.close()
                previous = line

with open("svli2.txt", 'r') as f:
        previous = None
        for line in f:
                if previous is not None:
                        if line.split()[0] == previous.split()[0] and line.split()[1] == previous.split()[1] and line.split()[2] == previous.split()[2] and line.split()[4] == previous.split()[4] and line.split()[5] == previous.split()[5] and line.split()[6] == previous.split()[6]:
                                final = open('tempsvli.txt', 'a')
                                print(line.split()[0],line.split()[1],line.split()[2],line.split()[3],line.split()[4],line.split()[5],line.split()[6],line.split()[7],",",previous.split()[7],sep ="\t" ,file=final)
                                final.close()
                        else:
                                final = open('tempsvli.txt', 'a')
                                print(line, sep = "\t",file = final)
                                final.close()
                if previous is None:
                        final = open('tempsvli.txt', 'a')
                        print(line, sep = "\t",file = final)
                        final.close()
                previous = line

with open("svcg2.txt", 'r') as f:
        previous = None
        for line in f:
                if previous is not None:
                        if line.split()[0] == previous.split()[0] and line.split()[1] == previous.split()[1] and line.split()[2] == previous.split()[2] and line.split()[4] == previous.split()[4] and line.split()[5] == previous.split()[5] and line.split()[6] == previous.split()[6]:
                                final = open('tempsvcg.txt', 'a')
                                print(line.split()[0],line.split()[1],line.split()[2],line.split()[3],line.split()[4],line.split()[5],line.split()[6],line.split()[7],",",previous.split()[7],sep ="\t" ,file=final)
                                final.close()
                        else:
                                final = open('tempsvcg.txt', 'a')
                                print(line, sep = "\t",file = final)
                                final.close()
                if previous is None:
                        final = open('tempsvcg.txt', 'a')
                        print(line, sep = "\t",file = final)
                        final.close()

                previous = line

with open("svci2.txt", 'r') as f:
        previous = None
        for line in f:
                if previous is not None:
                        if line.split()[0] == previous.split()[0] and line.split()[1] == previous.split()[1] and line.split()[2] == previous.split()[2] and line.split()[4] == previous.split()[4] and line.split()[5] == previous.split()[5] and line.split()[6] == previous.split()[6]:
                                final = open('tempsvci.txt', 'a')
                                print(line.split()[0],line.split()[1],line.split()[2],line.split()[3],line.split()[4],line.split()[5],line.split()[6],line.split()[7],",",previous.split()[7],sep ="\t" ,file=final)
                                final.close()
                        else:
                                final = open('tempsvci.txt', 'a')
                                print(line, sep = "\t",file = final)
                                final.close()
                if previous is None:
                        final = open('tempsvci.txt', 'a')
                        print(line, sep = "\t",file = final)
                        final.close()
                previous = line
