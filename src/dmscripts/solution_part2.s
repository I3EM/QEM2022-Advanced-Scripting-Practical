Image remove_polynomial_background(Image src) {
{{#include basis_poly.s}}
	

	Image A := realImage("", 8, 3, 3)
	A[0, 0] = dotProduct(xxy, xxy)
	A[1, 0] = dotProduct(xxy,  yy)
	A[2, 0] = dotProduct(xxy, yyy)
	
	A[0, 1] = dotProduct( yy, xxy)
	A[1, 1] = dotProduct( yy,  yy)
	A[2, 1] = dotProduct( yy, yyy)
	
	A[0, 2] = dotProduct(yyy, xxy)
	A[1, 2] = dotProduct(yyy,  yy)
	A[2, 2] = dotProduct(yyy, yyy)

	Image b := realImage("", 8, 3, 1)
	b[0, 0] = dotProduct(xxy, src)
	b[1, 0] = dotProduct( yy, src)
	b[2, 0] = dotProduct(yyy, src)

	Image solution := svDecomposition(A, b)
	
	Image result := realImage("", 8, x_size, y_size)
	result = src - (\
		round(getPixel(solution, 0, 0)) * xxy + \
		round(getPixel(solution, 1, 0)) *  yy + \
		round(getPixel(solution, 2, 0)) * yyy   \
	)

	return result
}