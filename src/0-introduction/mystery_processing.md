# Overview of the Mystery Processing

Omitting the function implementations, the processing that produced
our encoded image is as follows:
```java
{{#include ../dmscripts/mystery_appl.s}}
```

This gives us the big picture of what is happening here, that may be
summarized by the following diagram:
```mermaid
graph TD
    {{#include ../diagram.mermaid}}
    linkStyle 1 stroke:lime, color:lime
    linkStyle 2 stroke:lime, color:lime
    linkStyle 3 stroke:lime, color:lime
    linkStyle 4 stroke:lime, color:lime
    linkStyle 5 stroke:lime, color:lime
```
If we focus on the left (lime) part of this diagram, we can see that our *mystery image*
undergoes 4 processings:

1. A so-called "Mystery Swap".
2. The addition of some random polynomial.
3. The application of a transfert function, *with an external parameter*.
4. A metadata update, that do not change the image content.

Which gives us our *encoded image*. To revert back to the original image,
we will have to go through the following three steps, which will form
the different parts of the practical:

1. Revert the transfert function.
2. Remove the polynomial.
3. Swap back the image.
