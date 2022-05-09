# Performing the Inversion

```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    class mtf focus
    class tag,pspec,gspec,maxs,rand,mean,rand_vec done
```

Once we have got the `s` parameter we were looking for, we can now
invert the transfer function. The transfer function code is as follows:

```java
{{#include ../dmscripts/mystery_appl1c.s}}
```

Where `apply_inverse_gaussian_mtf` is defined as:

```java
{{#include ../dmscripts/mystery_part1c.s}}
```

As we can see here, this code only does a multiplication of the image by a function
(which never cancels) the Fourier space of the image.

This is done by doing a Fourier Tranform, multiplying by the function, and then doing
the inverse transformation on the result. Or, as summarized in pseudo-code:
```
s1  = fourier_transform(input)
s2  = multiply_by_f(s1)
out = inverse_fourier_transform(s2)
```

~~~admonish info title="`icol`, `irow`"
In Digital Micrograph's jargon, `icol` and `irow` are called *intrinsic variables*.
They can only be used in an image expression. In that context, they allow to define
functions of \\(x\\) (`icol`) and \\(y\\) (`irow`).

For example, one could add a polynomial \\(xy + 3\\) to image `img` with the following
expression:
```java
img +  icol * irow + 3
// Or, if we want to update `img`
img += icol * irow + 3
```

`icol` and `irow` are expressed in pixel unit, and match respectively the \\(x\\) and
\\(y\\) indexes of the pixel in the image. Therefore, `icol` grows from left to right,
and `irow` from top to bottom (which is the opposite direction to the usual one for
\\(y\\)), and they are both 0 for the top left pixel.
~~~

~~~admonish info title="`realFft`, `realIfft`"
`realFft` is the Digital Micrograph function to perform Fourier Transform on
real-valued images. Its reciprocal is `realIfft`.

To perform Fourier Transform on complex-valued images, one must use `fft` and
`iFft` instead.
~~~

## Inverting the Function

Doing the inverse operation is pretty simple. We need to reverse the order of
operations, and take the inverse of every operator, so this gives us:
```
s1  = inverse(inverse_fourier_transform)(input)
s2  = inverse(multiply_by_f)(s1)
out = inverse(fourier_transform)(s2)
```
Which expands to:
```
s1  = fourier_transform(input)
s2  = divide_by_f(s1)
out = inverse_fourier_transform(s2)
```
Which is exactly `apply_inverse_gaussian_mtf`, except we now use the inverse of \\(f\\).

The solution code is therefore the same as for `apply_inverse_gaussian_mtf`, except
for a single character (the `/=` operator that becomes a `*=` operator):

```java
{{#include ../dmscripts/solution_part1c.s}}
```

## Current Proposed Implementation

```admonish warning
A solution to the problem is given below.
Before consulting it, we encourage you to make your own tries.
```

~~~admonish example title="Solution" collapsible=true
```java
{{#include ../dmscripts/solution_part1a.s}}

{{#include ../dmscripts/solution_part1b.s}}

{{#include ../dmscripts/solution_part1c.s}}


Image src := getFrontImage()

{{#include ../dmscripts/solution_appl1a.s}}

{{#include ../dmscripts/solution_appl1b.s}}

{{#include ../dmscripts/solution_appl1c.s}}

showImage(step1)
```
~~~

<!-- ~~~admonish example title="Mystery Processing Recap" collapsible=true
```java
{{#include ../dmscripts/mystery_appl.s}}
```
~~~ -->

