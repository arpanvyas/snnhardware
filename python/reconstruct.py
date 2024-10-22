import numpy as np
from numpy import interp
import cv2
import random
from recep_field import rf
from parameters import param as par

def reconst_weights(weights, num, path):
	weights = np.array(weights)
	weights = np.reshape(weights, (par.pixel_x,par.pixel_x))
	img = np.zeros((par.pixel_x,par.pixel_x))
	for i in range(par.pixel_x):
		for j in range(par.pixel_x):
			img[i][j] = int(interp(weights[i][j], [par.w_min,par.w_max], [0,255]))	

	cv2.imwrite(path +'/'+ 'neuron' + str(num) + '.png' ,img)
	return img

def reconst_rf(weights, num):
	weights = np.array(weights)
	weights = np.reshape(weights, (par.pixel_x,par.pixel_x))
	img = np.zeros((par.pixel_x,par.pixel_x))
	for i in range(par.pixel_x):
		for j in range(par.pixel_x):
			#img[i][j] = int(interp(weights[i][j], [-2,3.625], [0,255]))	
			img[i][j] = random.randint(0,255)

	cv2.imwrite('neuron' + str(num) + '.png' ,img)
	return img

def random_img( num):
	img = np.zeros((par.pixel_x,par.pixel_x))

	for i in range(par.pixel_x):
		for j in range(par.pixel_x):
			#img[i][j] = int(interp(weights[i][j], [-2,3.625], [0,255]))	
			img[i][j] = random.randint(0,200)

	cv2.imwrite('random' + str(num) + '.png' ,img)
	return img


if __name__ == '__main__':

	#img = cv2.imread("images2/" + "69" + ".png", 0)
	#pot = rf(img)
	#reconst_rf(pot, 12)
	for i in range(0,4):
		random_img(i)