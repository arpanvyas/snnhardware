import numpy as np
import cv2
import math

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




for im_indx in range(0,10):

    s1 = str(im_indx)

    img = cv2.imread(s1+".png", 0)
    print img.shape

    output_name = 'img'+s1+'.bin'

    open(output_name, 'w').close()

    for i in range(28):
    	j=0
    	while(j<28):
    		with open(output_name, 'a') as file: 
    			file.write(int2bin(img[i][j+3],0,8))
    			file.write(int2bin(img[i][j+2],0,8))
    			file.write(int2bin(img[i][j+1],0,8))
    			file.write(int2bin(img[i][j],0,8))
    			file.write('\n')
    		j = j + 4