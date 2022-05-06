Image apply_inverse_gaussian_mtf(Image img, Number s) {
	ComplexImage fft := realFft(img)

	Number x_size = imageGetDimensionSize(fft, 0)
	Number y_size = imageGetDimensionSize(fft, 1)

	// In DM, the origin (aka null frequency) of a FFT is located in the middle
	// pixel
	Number x_0 = ceil(x_size / 2)
	Number y_0 = ceil(y_size / 2)

	fft /= exp( \
		- ((icol - x_0) * s/16 / 2 / x_size)**2 \
		- ((irow - y_0) * s/16 / 2 / y_size)**2 \
	)

	return realIfft(fft)
}