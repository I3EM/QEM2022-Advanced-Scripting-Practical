# Suggested Approach: Averaging Maxima Positions

## Peak Finding

Out of the many possibilities for retrieving the local maximums of a 1D image,
the simplest is probably to rely on the fact that, for a discrete function
\\(u_n\\) where \\(n\\) is an integer, the list of local maximums is defined by:
\\[\\{ n \in \mathbb{N} | u_{n - 1} \le u_n \text{ and } u_{n - 1} \le u_n \\}\\]

~~~admonish warning
This method may not work well in the presence of noise. In that case, you
can try to filter your input to get cleaner result. In our case, this is not 
necessary.
~~~

~~~admonish info title="The `getPixel` function"
Due to the way the `=` operator work on images, the result of using the
`[]` operator on an image (like in `img[1, 6]`) is a 0D point image.
However, we often need a `Number` instead of an `Image`. The do that,
we need to use the `getPixel` function. For example, if you need to
extract the value of say, the pixel `(1, 2)` of the image `img`, you
would do:
```java
getPixel(img, 1, 2)
```
~~~

## Averaging

Let \\(u_i\\) be a finite sequence of \\(n\\) values to be averaged, with
\\(n, i \in \mathbb{N}, i < n\\).

The mean \\(\overline{u}\\) is defined as:
\\[\overline{u} = \frac{1}{n} \sum_{i=0}^{n-1} u_i\\]

~~~admonish info title="Optional: cumulative averaging" collapsible=true
Sometimes, you need to maintain an average of the values you already got.
In this cases, it is more convenient to use the cumulative mean \\(\overline{u}_i\\):
\\[
    \begin{aligned}
        \overline{u}\_0       & = u_0 \\\\
        \overline{u}\_{i+1}   & = \overline{u}_i + \frac{u\_{i+1} - \overline{u}_i}{i+1}\\\\
        \overline{u}          & = \overline{u}\_{n}
    \end{aligned}
\\]
~~~

## Recap: How do I...

~~~admonish info title="... print a number or a string?" collapsible=true
To print something in Digital Micrograph in the `Results` window, you use
the `result` function:
```java
result("Here I print a string\n")
result("And now, here's a number:" + 42 + "\n")
result("I can also print the number alone :")
result(42 + "\n")
```
The `\n` character sequence is used to print a new line. You will want to
append it at the end of your strings for readability.
~~~

~~~admonish info title="... get the size of an image?" collapsible=true
`imageGetDimensionSize` allows one to get the size of one dimension of an
image.

It is used like this:
```java
Number size = imageGetDimensionSize(my_image_variable, the_dimension_i_want)
```
For example, if you want the first dimension (which is the \\(x\\) dimension)
of an image, you will do:
```java
imageGetDimensionSize(my_image_variable, 0)
```
For 2D, 3D and 4D images, the \\(y\\) dimension (second dimension) is `1`, for
\\(z\\) it is 2, and so on.
~~~

~~~admonish info title="... write a `for`-loop?" collapsible=true
`for`-loops in Digital Micrograph use a `C`-like syntax:
```java
// ++i is a shorthand for i = i + 1
for (Number i = 0 ; i < 10 ; ++i) {
    result(i + "\n")
}
```
This one means:
- Start with a number `i` equals to zero
- While `i` is lesser than 10, do:
    - Print `i`
    - Increase `i` by 1

The syntax can be broken down like this:
```java
for (Initialisation ; Loop condition ; What to do after each iteration) {
    What to do for each iteration
}
```
~~~

~~~admonish info title="... write an `if` statement?" collapsible=true
`if` statements in Digital Micrograph use a `C`-like syntax:
```java
Number n = random()
if (n < 0.5) {
    result("Less than 0.5!\n")
} else {
    result("More than 0.5!\n")
}
```
If you want to test different cases separately, one after the other, you can use `else if`:
```java
Number n = random()
if (n < 0.3) {
    result("Less than 0.3!\n")
} else if (n < 0.5) {
    result("Between 0.3 and 0.5!\n")
} else {
    result("More than 0.5!\n")
}
```
To combine different conditions into one, you can use `&&` (*and*) and `||` (*or*):
```
Number n = random()
if (0.3 < n && n < 0.5) {
    result("Between 0.3 AND 0.5!\n")
}

n = random()
if (n < 0.3 || 0.5 < n) {
    result("Either below 0.3 OR above 0.5!\n")
}
```
~~~

~~~admonish info title="... access a pixel value?" collapsible=true
The syntax for accessing a given pixel (let's say x = 1 and y = 43) of the image
`img` is:
```java
img[1, 43]
```
Tu use this access, you must do like this:
```java
// Here we change the value of the pixel.
img[1, 43] = 42
// Here we read the value of the pixel, as explained in "The getPixel function"
// info box above.
Number pixel_value = getPixel(img, 1, 43)
```
For 1D images, the syntax is the same, except \\(y\\) is always
equal to `0`, since whe only have a line image:
```java
// For pixel at x = 42
img[42, 0]
```
~~~
