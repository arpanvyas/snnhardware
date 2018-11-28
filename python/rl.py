import numpy as np
from matplotlib import pyplot as plt
from parameters import param as par

# global w_max, w_min, sigma
# w_max = 1.5
# w_min = -1
# sigma = 0.0625


def rl(t):
	# A_plus = 0.6
	# A_minus = 0.3
	# tau_plus = 8
	# tau_minus = 5
	

	if t>0:
		return -par.A_plus*np.exp(-float(t)/par.tau_plus)
	if t<=0:
		return par.A_minus*np.exp(float(t)/par.tau_minus)


#Have a look at this thing
def update(w, del_w):
	if del_w<0:
		return w + par.sigma*del_w*(w-abs(par.w_min))*par.scale
	elif del_w>0:
		return w + par.sigma*del_w*(par.w_max-w)*par.scale

if __name__ == '__main__':
	
	print rl(-20)*par.sigma

	