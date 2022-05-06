Image mystery_unswap(Image img) {
	Image fft := realFft(img)
	fft = rect(fft)
	Image result := realIfft(fft)
	result *= 2**10
	return result
}
