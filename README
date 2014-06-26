README
======

General
-------
Bootstrap Gaussian Kernel Regression in R using Scott's rule of thumb for bandwidth (Scott 1992). 

This program can be used to graphically identify non-linear trends in bivariate joint distributions. 


#### References
Scott DW (1992) Multivariate density estimation: Theory, practice, and visualization. Wiley.


C
--------
Tested on Mac OS X 10.7.5

Compiler: gcc-4.2

Architecture: x86_64

R version 3.0.1


Example
-------
The example data file **data.csv** was chosen to show that the method can uncover non-linear relationships.  The **data.csv** contains a sin function as the process model with Gaussian noise.

Run the following code from within R.

`
source('bgkreg.R')
D = read.csv('data.csv', header=T)
x = D$x
y = D$trig
kernelR(x,y, 'example.pdf', 'x','Gaus(10*sin(x), 4)')
`
