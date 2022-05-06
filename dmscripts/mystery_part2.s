// Return a random integer in the [min, max] interval, with a uniform
// distribution.
Number random_integer(Number min, Number max) {
	return round((max - min) * random() + min)
}

// Add a random polynomial background to the image
Image add_random_polynomial(Image src) {
{{#include basis_poly.s}}
	
	Image result := realImage("", 8, x_size, y_size)
	result = src + \
		random_integer(1, 10) * xxy + \
		random_integer(1, 10) *  yy + \
		random_integer(1, 10) * yyy
	
	return result
}