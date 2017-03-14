---
title: Embedding Data Directly in R-Code
layout: post
---
# Direct input of data frames

A little known feature of `read.table()` is the ability to incorporate data as text directly in code. Of course one can create vectors
from which data frames can be composed. Surely one has seen examples of this in elementary textbooks. 
The good news is that the`text` argument to read.table offers an easier way to bring in columns of text without need for additional
formatting.  This is useful for including small datasets directly in the code, for instance to document data frame manipulations.

The documentation of the text argument is terse:

> character string: if file is not supplied and this is, then data are read from the value of text via a text connection. Notice that a literal string can be
> used to include (small) data sets within R code.

Here's what it looks like on the first few rows of Fisher's Iris Data:

	iris.data <- read.table(header=TRUE, text=
	"Type	PW	PL	SW	SL
	0	2	14	33	50
	1	24	56	31	67
	1	23	51	31	69
	0	2	10	36	46
	1	20	52	30	65
	1	19	51	27	58")

Felicitously the `sep=''` default correctly identifies any whitespace as a field separator, and similarly the default line terminator
matches the embedded line endings.  Consequently there's no need to modify the text; copy and paste into the code just works.
It couldn't be any easier.

# So `textConnection` can be used anywhere a file is needed.

Under the hood the text argument is just syntactic sugar for first creating a `textConnection`, which can be used in place of a file:

	iris.data <- read.table(header=TRUE, file=
	textConnection("Type	PW	PL	SW	SL
	0	2	14	33	50
	1	24	56	31	67
	1	23	51	31	69
	0	2	10	36	46
	1	20	52	30	65
	1	19	51	27	58"))

`textConnection` can also be used with text returned by from a URL,
using the `RCurl` library like this:

    library(RCurl)
	read.table(textConnection(getURL(<some_url>))

Although the equivalent can be abbreviated just by

	read.table(<some_url>)
 




