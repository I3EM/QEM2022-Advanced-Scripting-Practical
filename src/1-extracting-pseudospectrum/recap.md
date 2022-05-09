# Reverting the Transfer Function

```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    class mtf focus
    class tag done
```

Let's start with the inversion of the transfer function. The corresponding
code excerpt is as follows:

```java
{{#include ../dmscripts/mystery_appl1c.s}}
```

Where `with_polynomial` is the input image. We see that there is a
parameter `s` that comes into play. In order to revert the function,
we will need to retrieve its value. If we look at its definition:

```java
{{#include ../dmscripts/mystery_appl1b1.s}}
```

```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    class mtf focus
    class tag done
    linkStyle 8 stroke:lime, color:lime
    linkStyle 9 stroke:lime, color:lime
    linkStyle 10 stroke:lime, color:lime
```

We see that `s` comes from a random source, and is therefore an unknown.
From there, we have 2 options:

1. Either the image exhibits some distinctive feature we can extract `s` from.
2. Or `s` is measurable with a different detector or microscope configuration,
   that will produce a different image we can work with.

In our case, it is not clear if 1 is true; however, we *do* have another image where
`s` that may be easier to work with: the Pseudospectrum. Indeed, if we look at
its definition:

```java
{{#include ../dmscripts/mystery_appl1b2.s}}
```

```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    class mtf focus
    class tag done
    linkStyle 8 stroke:lime, color:lime
    linkStyle 11 stroke:lime, color:lime
    linkStyle 12 stroke:lime, color:lime
```

We see that `s` is actually the the arithmetic mean of the Pseudospectrum
local maximums.

In order to revert  our transfer function, we must then perform the 3 following
steps:

1. Extract the Pseudospectrum.
2. Find its local maxima locations and average them to get the `s` parameter.
3. Knowing `s`, perform the transfer function inversion on the *encoded image*.

~~~admonish info title="The `:=` operator" collapsible=true
Working with images in Digital Micrograph may be slightly disturbing due to
the fact that several `Image` variables may reference a same image in
memory (this also applies to variants, such as `ComplexImage`, `RGBImage`...).
An image exists as long as there is an `Image` variable referencing it.

Therefore, here is a quick refresher on how the way assignments and functions
interacts with images.

Digital Micrograph supports to kind of assignments:
1. *Copy assignment* `=`. You may use this operator in two contexts:
   1. *Copy declaration*, like in `Image img1 = img2`.
      In this case you create a new `img1` as a clone of the image `img2`.
      You can then modify `img1` without changing `img2`.
   2. *In-place modification assignment*, such as in `img1 = img2 + img3`.
      Here, a temporary image is created for storing the result of `img2 + img3`, and
      then its content is converted to the intern type of `img1` and copied into its
      already allocated storage (for example, if `img1` is a `Real4` image and
      `img2 + img3` is a `Real8`, the result will be converted to `Real4`).
      This is useful if you need to update the content of an image.
2. Reference assignment `:=`. You may use this operator in four contexts:
   1. *Assignment of temporaries*, like in `Image img1 := img2 + img3`.
      In this case you assign the temporary image storing the result of the
      `img2 + img3` operation to the name `img1`, so you can use it again.
   2. *Reasignment of temporaries*, like in `img1 := img2 + img3`. This case
      is similar to the previous one, except that the reference previously
      stored in `img1` is discarded (if it was the last one, then the image is
      destroyed).
   3. *Reference declaration*, like in `Image img1 := img2`.
      In this case you declare `img1` as an alias of the image `img2`.
      Then, if you modify `img1`, you change `img2`.
   4. *Reference reasignment*, such as in `img1 := img2`.
      Same as the last one except that the reference previously
      stored in `img1` is discarded.

Please note that expressions like `Image img1 = img2 + img3` are technically allowed but are
lesser version of the equivalent `Image img1 := img2 + img3` because of the extra copy.

In the case of functions, `Image` arguments are taken as if using the `:=` operator.
This means that:
```java
void example(Image img2) {}

Image img1
example(img1)
```
is virtually equivalent to:
```java
Image img1
Image img2 := img1
```
~~~
