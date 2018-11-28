print 2.7*64*5+6*64
print -1*64*5+6*64
print 2.7*5+6
print -1*5+6

for i in range(1,21):
	i = i + 1

	#print "inbetween("+`i*64`+",val_out3,"+`(i+1)*64`+"): "+"val_out4 <= "+`600/i`,";"

l=0; m=0; i=64; j=64; k=64;

while i<1249:
	l = (64*600)/i;
	m = (64*600)/(i+1);

	if(l!=m):
			z = 64*600/k
			if(z>199):
				z = 0;
			print "inbetween("+`j+1`+",val_out3,"+`k`+"): "+"val_out4 <= "+`z`,";"
			j = k;
			k = i + 1
	if(l==m):
			k = k+1;
	i = i+1;


print 64*600/1200
print 64*600/1201
print 64*600/1238
print 64*600/1239