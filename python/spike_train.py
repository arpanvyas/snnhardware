import numpy as np
from numpy import interp
from neuron import neuron
import random
from matplotlib import pyplot as plt
from recep_field import rf
import cv2
from rl import rl
from rl import update
import math
from parameters import param as par

input_image = "mnist1/0/" + str(1) + ".png"
output_spikes = "look_ups/train.txt"

def encode(pot):

	#defining time frame of 1s with steps of 5ms
	# T = 3000;
	# dt = 0.005
	# time  = np.arange(0, T+dt, dt)

	#initializing spike train
	train = []

	for l in range(par.pixel_x):
		for m in range(par.pixel_x):
		
			temp = np.zeros([(par.T+1),])

			#calculating firing rate proportional to the membrane potential
			freq = interp(pot[l][m], [-1.069,2.781], [1,20])
			
			# print freq
			if freq<=0:
				print error
				
			freq1 = math.ceil(600/freq)

			#generating spikes according to the firing rate
			k = freq1
			if(pot[l][m]>0):
				while k<(par.T+1):
					temp[k] = 1
					k = k + freq1
			train.append(temp)
			# print sum(temp)
	return train

if __name__  == '__main__':
	# m = []
	# n = []

	img = cv2.imread(input_image, 0)

	pot = rf(img)

	# for i in pot:
	# 	m.append(max(i))
	# 	n.append(min(i))

	# print max(m), min(n)
	train = encode(pot)
	f = open(output_spikes, 'w')
	print np.shape(train)

	for i in range(201):
		for j in range(784):
			f.write(str(int(train[j][i])))
		f.write('\n')

	f.close()	
	# for x in train:
	# 	print sum(x)
	# T = 1000
	# temp = np.zeros([(T+1),])
	# freq = interp(2.5, [-1.25,2.75], [1,20])
	# freq1 = math.ceil(600/freq)
	# k = freq1
	# while k<(T+1):
	# 	temp[k] = 1
	# 	k = k + freq1
	# ttt = np.arange(0,len(temp),1)	

	# plt.plot(ttt,temp, 'r' )
	# plt.show()
