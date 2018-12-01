import numpy as np
from parameters import param as par
import math
from decimal import *
import random
from reconstruct import reconst_weights
from os import mkdir
from datetime import datetime

now = datetime.now

new_folder = './trained_weights_paper/{}'.format(now().strftime('%Y-%m-%d-%H:%M:%S'))
# actually make the folder
mkdir(new_folder)


# from os import mkdir
# import urllib.request/
# from datetime import datetime

# now = datetime.now

# new_folder = '/home/arpan/Desktop/SNN Summer Work/trained_images{}'.format(now().strftime('%Y-%m-%d-%H:%M:%S'))
# # actually make the folder
# mkdir(new_folder)



weight_neuron0 = '../ver/FEED/init_wt_wr0.dat'
weight_neuron1 = '../ver/FEED/init_wt_wr1.dat'
weight_neuron2 = '../ver/FEED/init_wt_wr2.dat'
weight_neuron3 = '../ver/FEED/init_wt_wr3.dat'
weight_neuron4 = '../ver/FEED/init_wt_wr4.dat'
weight_neuron5 = '../ver/FEED/init_wt_wr5.dat'
weight_neuron6 = '../ver/FEED/init_wt_wr6.dat'
weight_neuron7 = '../ver/FEED/init_wt_wr7.dat'
weight_neuron8 = '../ver/FEED/init_wt_wr8.dat'

# a = Decimal(3.625)
# a_split = (int(a//1),a%1)
# fr = a_split[1]
# bin_fr = ""

# for x in range(par.fr_bits):
# 	bin_fr = bin_fr + str(int(fr*2))	
# 	fr = (fr*2)%1

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


for t in range(-20,-1):

	print "8'b" + int2bin(abs(t),0,8) + ": lut_out = 32'b" + int2bin(-par.A_plus*np.exp(float(-t)/par.tau_plus)*par.sigma,par.fr_bits, par.fr_bits+par.int_bits) + "; //" + str(t)
  # print "8'b" + int2bin(abs(t),0,8) + ": lut_out = 24'b" + int2bin(par.A_minus*np.exp(float(t)/par.tau_minus)*par.sigma*512,par.fr_bits, par.fr_bits+par.int_bits) + "; //" + str(t)
# f = open('look_ups/initial_weights.txt', 'w')

print "-----------------------------------------------"

for t in range(-20,-1):

	#print "8'b" + int2bin(abs(t),0,8) + ": lut_out = 32'b" + int2bin(-par.A_plus*np.exp(float(-t)/par.tau_plus)*par.sigma*512,par.fr_bits, par.fr_bits+par.int_bits) + "; //" + str(t)
   print "8'b" + int2bin(abs(t),0,8) + ": lut_out = 24'b" + int2bin(par.A_minus*np.exp(float(t)/par.tau_minus)*par.sigma,par.fr_bits, par.fr_bits+par.int_bits) + "; //" + str(t)
# f = open('look_ups/initial_weights.txt', 'w')


synapse = np.zeros((par.n,par.m))

# for i in range(par.m):
# 	for j in range(par.n):
# 		a = random.uniform(0,0.4*par.scale)
# 		synapse[i][j] = a

# fl1 = open('look_ups/initial_weight.txt', 'w')
# fl1 = open('neuron1.txt', 'w')
# fl2 = open('neuron2.txt', 'w')
# fl3 = open('neuron3.txt', 'w')
# synapse = np.transpose(synapse)

# for i in range(par.m):
# 	s = int2bin(synapse[0][i],par.fr_bits, par.fr_bits+par.int_bits)
# 	fl1.write(s + '\n')

# for i in range(par.m):
# 	s = int2bin(synapse[1][i],par.fr_bits, par.fr_bits+par.int_bits)
# 	fl2.write(s + '\n')

# for i in range(par.m):
# 	s = int2bin(synapse[2][i],par.fr_bits, par.fr_bits+par.int_bits)
# 	fl3.write(s + '\n')		

# f.close()
# fl = open('look_ups/test_synapse.txt','w')

# for i in range(par.n):
# 	for j in range(par.m):
# 		fl.write(str(synapse[i][j]))
# 	fl.write('\n')
	
# fl.close			






# s = int2bin(-5.04,par.fr_bits, par.fr_bits+par.int_bits)s
# print s
# print bin2int(s)/math.pow(2,12)
	

# for t in range(2,21):
# 	#print par.A_minus*math.exp(t/par.tau_minus)*par.sigma*par.scale
# 	print -par.A_plus*np.exp(-float(t)/par.tau_plus)

divi = 4096/2

lines = [line.rstrip('\n') for line in open(weight_neuron0)]
lines = [x.strip() for x in lines] 
for i in range(par.m):
	synapse[0][i] = float(bin2int(str(lines[i])))/divi

lines = [line.rstrip('\n') for line in open(weight_neuron1)]
lines = [x.strip() for x in lines]  
for i in range(par.m):
	synapse[1][i] = float(bin2int(str(lines[i])))/divi

lines = [line.rstrip('\n') for line in open(weight_neuron2)]
lines = [x.strip() for x in lines]  
for i in range(par.m):
	synapse[2][i] = float(bin2int(str(lines[i])))/divi

lines = [line.rstrip('\n') for line in open(weight_neuron3)]
lines = [x.strip() for x in lines] 
for i in range(par.m):
	synapse[3][i] = float(bin2int(str(lines[i])))/divi
 
lines = [line.rstrip('\n') for line in open(weight_neuron4)]
lines = [x.strip() for x in lines] 
for i in range(par.m):
	synapse[4][i] = float(bin2int(str(lines[i])))/divi

lines = [line.rstrip('\n') for line in open(weight_neuron5)]
lines = [x.strip() for x in lines] 
for i in range(par.m):
	synapse[5][i] = float(bin2int(str(lines[i])))/divi

lines = [line.rstrip('\n') for line in open(weight_neuron6)]
lines = [x.strip() for x in lines] 
for i in range(par.m):
	synapse[6][i] = float(bin2int(str(lines[i])))/divi

lines = [line.rstrip('\n') for line in open(weight_neuron7)]
lines = [x.strip() for x in lines] 
for i in range(par.m):
	synapse[7][i] = float(bin2int(str(lines[i])))/divi 



# fl = open('look_ups/fpga_synapse.txt','w')

# for i in range(par.n):
#   for j in range(par.m):
#     fl.write(str(synapse[i][j]))
#   fl.write('\n')
  
# fl.close

# print synapse  
print max(synapse[0])
reconst_weights(synapse[0],0,new_folder)
reconst_weights(synapse[1],1,new_folder)
reconst_weights(synapse[2],2,new_folder)
reconst_weights(synapse[3],3,new_folder)
reconst_weights(synapse[4],4,new_folder)
reconst_weights(synapse[5],5,new_folder)
reconst_weights(synapse[6],6,new_folder)
reconst_weights(synapse[7],7,new_folder)
