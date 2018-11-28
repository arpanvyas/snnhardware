import numpy as np
import random
from matplotlib import pyplot as plt
from parameters import param as par


# global Pref, Pmin, Pth, D, Prest
# Pref = 0
# Prest = 0
# Pmin = -1
# Pth = 16
# D = 0.5

class neuron:
	def __init__(self):
		self.t_ref = 30
		self.t_rest = -1
		self.P = par.Prest
		# self.D = par.D
		# self.Pmin = Pmin
		# self.Prest = Prest
	def check(self):
		if self.P>= self.Pth:
			self.P = par.Prest
			return 1	
		elif self.P < par.Pmin:
			self.P  = par.Prest
			return 0
		else:
			return 0
	def inhibit(self):
		self.P  = par.Pmin
	def initial(self, th):
		self.Pth = th
		self.t_rest = -1
		self.P = par.Prest