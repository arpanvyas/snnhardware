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

f = open('seeds.dat', 'w')
for i in range(par.m):
	s = int2bin(random.randint(1, 65535),0,16)
	f.write(s + '\n')
f.close()
