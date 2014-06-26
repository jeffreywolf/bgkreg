# Gaussian Kernel Regression

system('R CMD SHLIB bgkreg.c')
dyn.load('bgkreg.so')

setLimits = function(vec){
	# Used for setting plot limits and grid for kernel regression
	minimum = ifelse(min(vec) < 0,  min(vec)*1.2, min(vec)*0.8)
	maximum = ifelse(max(vec) < 0,  max(vec)*0.8,  max(vec)*1.2)
	return (c(minimum, maximum))
}

kernelR = function(X, Y, name, xlab, ylab){
	# Plot bootstrap kernel regression estimate
	pdf(name)
	par(mai=c(1,1,1,1))

	# Set parameteres
	n = length(X)
	m = 100 # length of grid used for kernel regression
	xlimits = setLimits(X)
	grid = seq(xlimits[1], xlimits[2], length.out = m)
	bw = bw.nrd(X) # set the bandwidth using R
	result = .C(
			'kernelR', 
			as.integer(n), 
			as.double(X), 
			as.double(Y),
			as.double(bw), 
			as.integer(m), 
			as.double(grid), 
			y=double(m)
		)

	# set plot parameters
	ylimits = setLimits(Y)
	plot(xlimits, ylimits, type='n', xaxs='i', yaxs='i',
		xlab = xlab, ylab = ylab, cex.axis = 1.25)
	points(X, Y, pch = 20, col = 'grey')
	lines(grid, result$y, lwd = 2)
	
	bootstrap_estimates = data.frame()
	for(i in 1:200){
		n = 100
		indices = sample(1:length(X), n, replace = T)
		result = .C(
				'kernelR',
				as.integer(n),
				as.double(X[indices]),
				as.double(Y[indices]),
				as.double(bw),
				as.integer(m),
				as.double(grid),
				y = double(m)
			)
		bootstrap_estimates = rbind(bootstrap_estimates, result$y)
	}

	# Add bootstrap 95% CI to figure
	lines(
		grid, 
		apply(
			bootstrap_estimates, 
			2, 
			quantile, 
			probs = 0.025
			), 
		col ='blue',
		lwd = 2
		)
	lines(
		grid, 
		apply(
			bootstrap_estimates, 
			2, 
			quantile, 
			probs = 0.975
			), 
		col ='blue',
		lwd = 2
		)
	dev.off()
}