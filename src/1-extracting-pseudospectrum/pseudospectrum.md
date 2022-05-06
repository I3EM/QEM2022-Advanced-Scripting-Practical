# Extracting the Pseudospectrum

```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    class tag focus
    class pspec obj
```

We have just seen that before even starting to process our encoded image,
we had to extract another "Pseudospectrum" image from its metadata. To know
how we should proceed, let's take a look at the code that stored that
Pseudospectrum:

```java
{{#include ../dmscripts/mystery_appl1a.s}}
```

The `add_image_tag` function is defined as follows:

```java
{{#include ../dmscripts/mystery_part1a.s}}
```

We can see here that the `img` metadata is manipulated through a `TagGroup`
that we can obtain by calling `imageGetTagGroup` on the image. Then,
the actual metadata may be set by calling the corresponding `tagGroupSetTagAs*`
on the `TagGroup` (namely `tagGroupSetTagAsNumber` and `tagGroupSetTagAsImage`
in our case).

~~~admonish info title="`imageGetDimensionSize(img, n)`"
Returns the size of the `n`-th dimension of the image `img`.
~~~

## Getting Back Metadata

If we want to get that metadata back, we will need the `tagGroupGetTagAs*` family
of functions, specifically `tagGroupGetTagAsNumber` and `tagGroupGetTagAsImage`.
`tagGroupGetTagAsNumber`, for example, is used as such:

```java
Number n
tagGroupGetTagAsNumber(tags, "Tag Path", n)
result("Read number " + n + "\n")
```

As those functions may fail (the tag path may not exist, the data type
may be incorrect...), they signal succes by returning `1` and failure by
returning `0`. This behaviour may be used as such:

```java
Number n
if (tagGroupGetTagAsNumber(tags, "Tag Path", n)) {
    result("Succefully read number " + n + "\n")
} else {
    result("The tag 'Tag Path' does not exist on this image!\n")
}
```

In the case of `tagGroupGetTagAsArray`, the story become a little
more complicated. `tagGroupGetTagAsArray` will only write data to
an already allocated image. Therefore, one need to know in advance
the size of the image, so they can allocate the right amount. That is
why a common pattern is to store the image size in an other number
tag. When the image `size` is known, `tagGroupGetTagAsArray` is
used as such:

```java
Image img_tag := RealImage("", 8, size)
tagGroupGetTagAsArray(tags, "Tag Path", img_tag)
```

## Getting Back the Pseudospectrum

Putting thoses functions together, we can easily build an extraction
function for us to use:

```java
{{#include ../dmscripts/solution_part1a.s}}
```

The complete script should then look like this:

```java
{{#include ../dmscripts/solution_part1a.s}}


Image src := getFrontImage()

{{#include ../dmscripts/solution_appl1a.s}}

showImage(pseudo_spectrum)
```

<!-- ~~~admonish example title="Mystery Processing Recap" collapsible=true
```java
{{#include ../dmscripts/mystery_appl.s}}
```
~~~ -->

