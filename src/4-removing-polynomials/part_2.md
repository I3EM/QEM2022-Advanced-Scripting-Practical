# Removing the Distortion

```admonish question title="Reflection Time"
Now, we will discuss the problem together as a class, and see how we can solve it.
```

```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    class polynomial focus
    class mtf,tag,pspec,gspec,maxs,rand,mean,rand_vec done
```

Now that the transfert function was undone, let's go to the next step:
removing the polynomial background. This was written as:

```java
{{#include ../dmscripts/mystery_appl2.s}}
```

If we look at the exact definition of that function call, we get:

```java
{{#include ../dmscripts/mystery_part2.s}}
```

If we translate this in math terms, it is equivalent to the following
equation:

\\[ I_\mathrm{out}(x, y) = I_\mathrm{in}(x, y) + A x^2 y + B y^2 + C y^3 \\]

Where \\(I_\mathrm{in}\\) and \\(I_\mathrm{out}\\) are respectively the
input and output image, and \\(A\\), \\(B\\) and \\(C\\) are random integer between
1 and 10.

We therefore need to somehow recover the exact values of \\(A\\), \\(B\\) and \\(C\\).

~~~admonish info title="`realImage`"
Allocates a floating-point, real-valued image. Is used as such:
```java
Number bytes_number = 8 // Either 4 or 8; defines the precision
Number x_size = 100
Number y_size = 100
Number z_size = 100
Number t_size = 100
// 1D image
Image img := realImage("Image name", bytes_number, x_size)
// 2D image
Image img := realImage("Image name", bytes_number, x_size, y_size)
// 3D image
Image img := realImage("Image name", bytes_number, x_size, y_size, z_size)
// 4D image
Image img := realImage("Image name", bytes_number, x_size, y_size, z_size, t_size)
```
~~~