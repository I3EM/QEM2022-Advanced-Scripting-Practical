Image mystery_swap(Image img) {
	img *= 2**-10
	Image fft := realfft(img)
	img *= 2**10
	fft = polar(fft)
	return realifft(fft)
}
