Number mean_maximum_positions(Image img) {
	Number size = imageGetDimensionSize(img, 0)

	Number mean = 0
	Number maximums_number = 0

	for (Number i = 1 ; i < size - 1 ; ++i) {
		if (getPixel(img, i - 1, 0) <= getPixel(img, i, 0) && \
			getPixel(img, i + 1, 0) <= getPixel(img, i, 0)) {
			++maximums_number
			mean += (i - mean)/maximums_number
			++i
		}
	}

	return mean
}