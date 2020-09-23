import random

c2Rleft = 5398184
c2Rright = 24684540
c2Lleft = 82455
c2Lright = 22011009
c3Lleft = 158639
c3Lright = 22962476
c3Rleft = 4552934
c3Rright = 31845060
cXleft = 277911
cXright  = 22628490

c2Rdist = c2Rright - c2Rleft
c2Ldist =  c2Lright - c2Lleft
c3Rdist = c3Rright - c3Rleft
c3Ldist =  c3Lright - c3Lleft
cXdist = cXright - cXleft

totalchr = c3Rdist + c3Ldist + c2Rdist + c2Ldist + cXdist
cp2R = c2Rdist / totalchr
cp2L = c2Ldist / totalchr
cp3R = c3Rdist / totalchr
cp3L = c3Ldist / totalchr
cpX = cXdist / totalchr

lenX = 1000000 * cpX
len2L = 1000000 * cp2L
len2R = 1000000 * cp2R
len3R = 1000000 * cp3R
len3L = 1000000 * cp3L

cX = []
while len(cX) < lenX:
       #This checks to see if there are duplicate numbers
 r = random.randint(cXleft,cXright)
 if r not in cX :
  cX.append(r)
  with open('peak.txt', 'a') as union:
   print("peak"+str(r),"chrX",r,r + 2,"+",file=union)

cX.clear()

c2R = []
while len(c2R) < len2R:
       #This checks to see if there are duplicate numbers
 r = random.randint(c2Rleft,c2Rright)
 if r not in c2R :
  c2R.append(r)
  with open('peak.txt', 'a') as union:
   print("peak"+str(r),"chr2R",r,r + 2,"+",file=union)

c2R.clear()

c3R = []
while len(c3R) < len3R:
       #This checks to see if there are duplicate numbers
 r = random.randint(c3Rleft,c3Rright)
 if r not in c3R:
  c3R.append(r)
  with open('peak.txt', 'a') as union:
   print("peak"+ str(r),"chr3R",r,r + 2,"+",file=union)

c3R.clear()

c2L = []
while len(c2L) < len2L:
       #This checks to see if there are duplicate numbers
 r = random.randint(c2Lleft,c2Lright)
 if r not in c2L :
  c2L.append(r)
  with open('peak.txt', 'a') as union:
   print("peak"+str(r),"chr2L",r,r + 2,"+",file=union)

c2L.clear()

c3L = []
while len(c3L) < len3L:
       #This checks to see if there are duplicate numbers
 r = random.randint(c3Lleft,c3Lright)
 if r not in c3L :
  c3L.append(r)
  with open('peak.txt', 'a') as union:
   print("peak"+ str(r),"chr3L",r,r + 2,"+",file=union)

c3L.clear()
