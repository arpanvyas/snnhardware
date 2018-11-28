import numpy as np
from parameters import param as par
import math
from decimal import *
import random
from reconstruct import reconst_weights


def int2bin(z,frac_bits,num):
    i = int(z*math.pow(2,frac_bits))
    s1 = ''
    for m in range(0,num):
       s1 = "0" + s1
    if i == 0: return s1
    si = ''
    j = 1
    while (i > 0 or j < num+1):
        if i & 1 == 1:
            si = "1" + si
        else:
            si = "0" + si
        i /= 2
        j += 1
    return si

def bin2int(s):
   def toTwosComplement(binarySequence):
       convertedSequence = [0] * len(binarySequence)
       carryBit = 1
       # INVERT THE BITS
       for i in range(0, len(binarySequence)):
           if binarySequence[i] == '0':
               convertedSequence[i] = 1
           else:
               convertedSequence[i] = 0

       # ADD BINARY DIGIT 1

       if convertedSequence[-1] == 0: #if last digit is 0, just add the 1 then there's no carry bit so return
               convertedSequence[-1] = 1
               return ''.join(str(x) for x in convertedSequence)

       for bit in range(0, len(binarySequence)):
           if carryBit == 0:
               break
           index = len(binarySequence) - bit - 1
           if convertedSequence[index] == 1:
               convertedSequence[index] = 0
               carryBit = 1
           else:
               convertedSequence[index] = 1
               carryBit = 0

       return ''.join(str(x) for x in convertedSequence)
   num = len(s)
   sign = 0
   if(s[0]=="1"):
      s=toTwosComplement(s)
      sign = 1
   n=0
   l=1
   for i in range(0,num):
      k=num-1-i
      n=n+int(s[k])*l
      l=l*2
   if(sign):
      return -1*n
   else:
      return n


#Generating RNG seeds
f = open('seeds.dat', 'w')
for i in range(par.m):
  s = int2bin(random.randint(1, 65535),0,16)
  f.write(s + '\n')
f.close()




synapse = np.zeros((par.n,par.m))


for i in range(par.n):
 	for j in range(par.m):
 		a = random.uniform(0,0.4*par.scale)
 		synapse[i][j] = a
fl0 = open('init_weight0.dat', 'w')
fl1 = open('init_weight1.dat', 'w')
fl2 = open('init_weight2.dat', 'w')
fl3 = open('init_weight3.dat', 'w')
fl4 = open('init_weight4.dat', 'w')
fl5 = open('init_weight5.dat', 'w')
fl6 = open('init_weight6.dat', 'w')
fl7 = open('init_weight7.dat', 'w')

for i in range(par.m):
  s = int2bin(synapse[0][i],par.fr_bits, par.fr_bits+par.int_bits)
  fl0.write(s + '\n')
for i in range(par.m):
 	s = int2bin(synapse[1][i],par.fr_bits, par.fr_bits+par.int_bits)
 	fl1.write(s + '\n')
for i in range(par.m):
 	s = int2bin(synapse[2][i],par.fr_bits, par.fr_bits+par.int_bits)
 	fl2.write(s + '\n')		
for i in range(par.m):
 	s = int2bin(synapse[3][i],par.fr_bits, par.fr_bits+par.int_bits)
 	fl3.write(s + '\n')		
for i in range(par.m):
 	s = int2bin(synapse[4][i],par.fr_bits, par.fr_bits+par.int_bits)
 	fl4.write(s + '\n')		
for i in range(par.m):
 	s = int2bin(synapse[5][i],par.fr_bits, par.fr_bits+par.int_bits)
 	fl5.write(s + '\n')		
for i in range(par.m):
 	s = int2bin(synapse[6][i],par.fr_bits, par.fr_bits+par.int_bits)
 	fl6.write(s + '\n')		 	
for i in range(par.m):
 	s = int2bin(synapse[7][i],par.fr_bits, par.fr_bits+par.int_bits)
 	fl7.write(s + '\n')		

print int2bin(.4,12,24)


fl0.close()
fl1.close()
fl2.close()
fl3.close()
fl4.close()
fl5.close()
fl6.close()
fl7.close()


# fl = open('look_ups/test_synapse.txt','w')
# for i in range(par.n):
# 	for j in range(par.m):
#  		fl.write(str(synapse[i][j]))
#  		fl.write('\n')
	
# fl.close
