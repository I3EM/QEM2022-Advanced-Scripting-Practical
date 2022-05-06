	Number x_size = imageGetDimensionSize(src, 0)
	Number y_size = imageGetDimensionSize(src, 1)

	Image xxy := realImage("", 8, x_size, y_size)
	xxy = icol * icol * irow / x_size / x_size / y_size
	Image  yy := realImage("", 8, x_size, y_size)
	yy  = irow * irow / y_size / y_size
	Image yyy := realImage("", 8, x_size, y_size)
	yyy = irow * irow * irow / y_size / y_size / y_size