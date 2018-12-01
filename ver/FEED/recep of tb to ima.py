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
        

img_tb = open('image_ret.bin','r')
line = img_tb.readlines()


img = np.zeros((28,28))
for i in range(28):
    for j in range(28):
        img[i][j] = bin2int("0" + line[i*28+j].rstrip())

        
print img

def reconst_rf(weights, num):
    weights = np.array(weights)
    weights = np.reshape(weights, (28,28))
    img = np.zeros((28,28))
    for i in range(28):
        for j in range(28):
            img[i][j] = int(interp(weights[i][j], [-2,3.625], [0,255])) 


cv2.imwrite('recnst' + '.png' ,img)



# img = cv2.imread("1.png", 0)
# print img.shape

# open('img.bin', 'w').close()

# for i in range(28):
# 	j=0
# 	while(j<28):
# 		with open('img.bin', 'a') as file: 
# 			file.write(int2bin(img[i][j+3],0,8))
# 			file.write(int2bin(img[i][j+2],0,8))
# 			file.write(int2bin(img[i][j+1],0,8))
# 			file.write(int2bin(img[i][j],0,8))
# 			file.write('\n')
# 		j = j + 4