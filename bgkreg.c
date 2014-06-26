#include <R.h> 
#include <Rmath.h>

void kernelR(int *n, double *X, double *Y, double *bw, int *m, double *g2,
double *res2)
{ 
	/* 
	Return kernel regression estimates at m gridpoints. n is the 
	length of the vectors X and Y, m is the number of grid points g2, 
	and res2 is a vector of length m with the kernel regression 
	estimates at the m grid points. The bw parameter is the bandwidth.
	*/

	int i, j;
	double a1, a2, c;
	for(i = 0; i < *m; i++){
		a1 = 0.0;
		a2 = 0.0;
		for(j = 0; j < *n; j++){
			c = dnorm((X[j]-g2[i]), 0, *bw, 0);
			a1 += Y[j] * c;
			a2 += c; }
			res2[i] = a1/a2; 
		}
	}