# Averaging Maxima Positions

```admonish question title="Reflection Time"
Now, we will discuss the problem together as a class, and see how we can solve it.
```

```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    class gspec focus
    class tag,pspec done
    class maxs,mean obj
```

Now that we have our pseudospectrum, it is time to actually extract the
`s` value we are looking for. If we look at the code:

```java
{{#include ../dmscripts/mystery_appl1b.s}}
```

We can see that the `s` value is the integer quotient of the Euclidian
division by 8 of the arithetic mean of the positions of the pseudospectrum
local maximums.

Therefore, we need to locate the pseudospectrum local maximums, perform
the arithmetic mean, and then the Euclidian division.

The code excerpt above should be sufficient to define the problem, but
in case implementation details are desired, here they are:

~~~admonish info title="Functions Details" collapsible=true
```java
{{#include ../dmscripts/mystery_part1b.s}}
```
~~~