# Suggested Approach: Linear Least Squares

*Linear Least Squares* is a method to find a solution to the problem:

\\[ f(x, y, \dots) = A a(x, y, \dots) + B b(x, y, \dots) + \dots + r(x, y, \dots) \\]

Where \\(f\\) is a function that you know and want to express in terms of a linear
combination of known functions \\(a\\), \\(b\\), \\(c\\)... Since such a linear
combination usually does not exist, there is always a residual function \\(r\\). 
The goal is then to find a linear combination (in other words, the values for the
coefficients \\(A\\), \\(B\\), ...) that is the closest to \\(f\\), and so to make
\\(r\\) as small as possible (with respect to the quadratic \\(L_2\\) norm, hence the
name *Least Squares*)).

In that equation, \\(f\\), \\(r\\), \\(a\\), \\(b\\), ... may take any number
of variables and those may be integers (which means it can be a \\(n\\)-dimensional
image for example); their return value may also be multidimensional.

This method is usually used in 2 contexts:

1. When \\(f\\) is known to be a linear combination of known basis functions, possibly coming
   from a noisy measurement, and we want to estimate as best as we can the proportion
   of each basis function in \\(f\\) disregarding the noise.
2. When \\(f\\) comes from a measurement whose systematic noise is known to be a linear
   combination of known basis functions, and we want to remove the noise as best as we can.

In our case, we fall in the second context.

*Linear Least Square* consist in solving the following matrix equation:

\\[ \mathbf{A} \pmb{x} = \pmb{v} \\]

Where the matrix \\(\mathbf{A}\\) is defined as:

\\[
    \begin{pmatrix}
    a \cdot a & a \cdot b & a \cdot c & \cdots \\\\
    b \cdot a & b \cdot b & b \cdot c & \cdots \\\\
    c \cdot a & c \cdot b & c \cdot c & \cdots \\\\
      \vdots  &   \vdots  &   \vdots  & \ddots
    \end{pmatrix}
\\]

with \\(\cdot\\) being the dot product, the vector \\(\pmb{v}\\) is
defined as:

\\[
    \begin{pmatrix}
    a \cdot f \\\\
    b \cdot f \\\\
    c \cdot f \\\\
      \vdots
    \end{pmatrix}
\\]

and the vector \\(\pmb{x}\\) which is the vector of best estimates we are
looking for, defined as:

\\[
    \begin{pmatrix}
    A \\\\
    B \\\\
    C \\\\
      \vdots
    \end{pmatrix}
\\]

The residual \\(r\\) may then be computed as:
\\[ r =  f - A a - B b - C c - \dots \\]

~~~admonish tip
In the previous section, the *basis images* were defined as such:
```java
{{#include ../dmscripts/basis_poly.s}}
```
~~~

~~~admonish info
The dot product between two images is done in Digital Micrograph with
the `dotProduct` function:
```java
dotProduct(img1, img2)
```
~~~

~~~admonish info
The \\( \mathbf{A} \pmb{x} = \pmb{v} \\) matrix equation can be solved without
computing the matrix inverse of \\(\mathbf{A}\\) (which is computionally intensive),
using dedicated solver functions, such as 
[`numpy.linalg.solve`](https://numpy.org/doc/stable/reference/generated/numpy.linalg.solve.html)
and [`numpy.linalg.lstsq`](https://numpy.org/doc/stable/reference/generated/numpy.linalg.lstsq.html)
for python.

In Digital Micrograph, the corresponding solver function is `svDecomposition`,
that is used as such:
```java
Image A := realImage("", 8, 3, 3)
A[0, 0] = 1
A[1, 0] = 2
A[2, 0] = 3

A[0, 1] = 4
A[1, 1] = 5
A[2, 1] = 6

A[0, 2] = 7
A[1, 2] = 8
A[2, 2] = 9

// This is a row vector, but a column vector would also work.
// In any case, it will be interpreted as a column vector for
// the purpose of svDecomposition
Image b := realImage("", 8, 3, 1)
b[0, 0] = 10
b[1, 0] = 11
b[2, 0] = 12

// This return a row vector for programming reasons, but mathematically
// it is a column vector.
Image x := svDecomposition(A, b)
showImage(x)
```
This script solves the following matrix equation:

\\[
    \begin{pmatrix}
    1 & 2 & 3 \\\\
    4 & 5 & 6 \\\\
    7 & 8 & 9
    \end{pmatrix}
    \pmb{x} =
    \begin{pmatrix}
    10 \\\\
    11 \\\\
    12
    \end{pmatrix}
\\]
~~~

```admonish warning
The name of the `svDecomposition` function is misleading. While the *Singular
Value Decomposition* (SVD) may be used to write a solver to the
\\( \mathbf{A} \pmb{x} = \pmb{v} \\) equation, it is a different procedure.

You can learn more about the SVD with
[Steve Brunton's *Singular Value Decomposition* series on Youtube](https://www.youtube.com/playlist?list=PLMrJAkhIeNNSVjnsviglFoY2nXildDCcv).
```

```admonish warning
The \\( \mathbf{A} \\) matrix is numerically ill-conditioned here.
This means that the accuracy of the result strongly depends on both:
1. The floating point type *precision* used (often *single* or *double* precision,
   respectively 4 and 8 bytes).
2. The rounding errors of the floating point operations.

In other words, for best precision, you should:
1. Use double-precision floating points (8 bytes, or `Real8` in Digital Micrograph).
2. Not use matrix inversion on \\( \mathbf{A} \\) and use instead a proper linear
   matrix equation solver such as `svDecomposition` in Digital Micrograph.
3. Try to normalize your \\(a\\), \\(b\\), ... functions in case your result
   are unsatisfactory, since big discrepancies in the relative amplitude of your
   functions may lead to rounding errors (this was already done for you in this
   practical)
```

## References

Lawson, Charles L.; Hanson Richard J. (1995). *Solving Least Square Problems*, SIAM
