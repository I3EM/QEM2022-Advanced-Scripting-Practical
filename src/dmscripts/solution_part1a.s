Image get_image_tag(Image img, String tag) {
	TagGroup tags = imageGetTagGroup(img)

	Number size
	tagGroupGetTagAsNumber(tags, tag + " Size", size)

	Image img_tag := realImage("", 8, size)
	tagGroupGetTagAsArray(tags, tag, img_tag)

	return img_tag
}