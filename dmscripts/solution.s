{{#include solution_part1a.s}}

{{#include solution_part1b.s}}

{{#include solution_part1c.s}}

{{#include solution_part2.s}}


Image src := getFrontImage()

{{#include solution_appl1a.s}}

{{#include solution_appl1b.s}}

{{#include solution_appl1c.s}}

{{#include solution_appl2.s}}

{{#include solution_appl3.s}}

Image normalized := min(255, max(0, round(out)))
showImage(normalized)
