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

~~~admonish info title="The `sum`-pattern"
Due to the way the `=` operator work on images, the result of using the
`[]` operator on an image (like in `img[1, 6]`) is a 0D point image.
However, we often need a `Number` instead of an `Image`. The most
reliable way to do that is to use the `sum` function, which gives
us a `Number`. Since a 0D image has only 1 value, the sum returns this
value.
Therefore, if you need to extract the value of say, the pixel `(1, 2)`
of the image `img`, you would do:
```java
sum(img[1, 2])
```
~~~

## Cumulative Averaging

Let \\(u_i\\) be a finite sequence of \\(n\\) values to be averaged, with
\\(n, i \in \mathbb{N}, i < n\\).

The mean \\(\overline{u}\\) is defined as:
\\[\overline{u} = \frac{1}{n} \sum_{i=0}^{n-1} u_i\\]

While one could calculate a mean by computing this simple
and efficient sum, it is sometime more convenient to use
the cumulative mean \\(\overline{u}_i\\):
\\[
    \begin{aligned}
        \overline{u}\_0       & = u_0 \\\\
        \overline{u}\_{i+1}   & = \overline{u}_i + \frac{u\_{i+1} - \overline{u}_i}{i+1}\\\\
        \overline{u}          & = \overline{u}\_{n}
    \end{aligned}
\\]

With this last algorithm, you can compute the average as you get new
values so you do not need to store them.
