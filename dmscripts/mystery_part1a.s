// Stores the `img_tag` 1D image as a tag of the `img` image under the `tag` path,
// alongside with its size.
void add_image_tag(Image img, String tag, Image img_tag) {
	TagGroup tags = imageGetTagGroup(img)

	tagGroupSetTagAsArray(tags, tag, img_tag)
	tagGroupSetTagAsNumber(tags, tag + " Size", imageGetDimensionSize(img_tag, 0))
}