// Returns a random number in the [min, max] interval, with a uniform
// distribution.
Number random_uniform(Number min, Number max) {
	return (max - min) * random() + min
}
// Returns a list (as a 1D image) of random numbers in the [min, max]
// interval, with a uniform distribution.
Image random_uniform_image(Number size, Number min, Number max) {
	Image img := realImage("", 8, size)
	
	for (Number i = 0 ; i < size ; ++i) {
		img[i, 0] = random_uniform(min, max)
	}
	
	return img
}

// Returns 1 if the distance between any two values of the input list `img`
// is less than `min_size`
Number has_close_values(Image img, Number min_size) {
	Number n = imageGetDimensionSize(img, 0)
	for (Number i = 0 ; i < n ; ++i) {
		for (Number j = 0 ; j < i ; ++j) {
			if (abs(sum(img[i, 0]) - sum(img[j, 0])) < min_size) {
				return 1
			}
		}
	}
	return 0
}

// Sort the input list `img` in-place
void bubble_sort(Image img) {
	Number size = imageGetDimensionSize(img, 0)
	Number is_unsorted = 1
	while (is_unsorted) {
		Number swapped_values = 0
		for (Number i = 0 ; i < size - 1 ; ++i) {
			if (sum(img[i + 1, 0] < img[i, 0])) {
				Number temp = sum(img[i, 0])
				img[i, 0] = img[i + 1, 0]
				img[i + 1, 0] = temp
				++swapped_values
			}
		}
		is_unsorted = swapped_values
	}
}

// Generate a list of random values in the [min, max] interval that are
// guaranteed to be least distant by `min_dist` between each other
Image random_image_with_min_dist(Number size, Number min, Number max, Number min_dist) {
	Image out := random_uniform_image(size, min, max)

	while (has_close_values(out, min_dist)) {
		out := random_uniform_image(size, min, max)
	}

	bubble_sort(out)

	return out
}

// Generate a polynomial 1D "pseudospectrum" of length `size` bearing
// maximums at the specified `maximum_positions`
Image pseudospectrum_with_maximums_at(Number size, Image maximum_positions) {
	Image img := realImage("", 8, size)
	Number peak_numbers = imageGetDimensionSize(maximum_positions, 0)
	
	img = icol/size * (icol - size)/size
	for (Number i = 0 ; i < peak_numbers - 1 ; ++i) {
		img *= (icol - sum(maximum_positions[i, 0]))/size
		Number middle = (sum(maximum_positions[i, 0]) + sum(maximum_positions[i + 1, 0])) / 2
		img *= (icol - middle)/size
	}
	img *= (icol - sum(maximum_positions[peak_numbers - 1, 0]))/size
		
	for (Number i = 1 ; i < size ; ++i) {
		img[i, 0] += img[i - 1, 0]
	}
	
	return img
}