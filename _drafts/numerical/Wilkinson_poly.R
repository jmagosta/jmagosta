# unstable Wilkinson's polynomial
# JMA 17 Aug 2017
#
# Comes out of the no-im-not-giving-you-my-data project
#
#  FP precision of an R double on an IEEE 754-compliant platform (e.g. an x86) is not quite 16 decimal digits:
#  See Numerical Characteristics of the Machine in R documentation
#  .Machine$double.eps
#  .Machine$integer.max  = 2^31 - 1
library(jsonlite)

if (!("RProtoBuf"  %in% .packages(all=TRUE)) ) {
    install.packages("RProtoBuf")
}
library(RProtoBuf)
options(digits = 22)

plot.it<- TRUE
# Expanding the polynomial, one finds
# Note this suffers from a few percent noise due to integer overflow
wilkinson.20 <- function(x) {
    y <- x^20 - 210L * x^19 + 20615L * x^18 - 1256850L * x^17 + 53327946L * x^16 -
    1672280820L * x^15 +40171771630L * x^14 - 756111184500L * x^13 +
    11310276995381L * x^12 - 135585182899530L * x^11 +
    1307535010540395L * x^10 - 10142299865511450L * x^9 +
    63030812099294896L * x^8 - 311333643161390640L * x^7 +
    1206647803780373360L * x^6 - 3599979517947607200L * x^5 +
    8037811822645051776L * x^4 - 12870931245150988800L * x^3 +
    13803759753640704000L * x^2 - 8752948036761600000L * x +
    2432902008176640000L
    y
}


# Evaluate the Wilkinson polynomial by term by term construction -
# w_n(x) = \product_{k=1\ldots n}(x-k)
# This avoids integer rounding errors -  a smoother version
wilkinson.products <- function(x, nn=20) {
    w <- function(x, n=nn) {
        v <- rep(x, n) - seq(n)  # The terms in the polynomial \product (x-1), (x-2), ...
        Reduce( '*', v)
    }
sapply(x, w)
}

# Plot the difference over one interval of the explicit polynomial
# and the more accurate term by term functions
if (plot.it) {
    par(mfrow=c(2,1))
    par(mar=c(0,2,4,2))
    the.interval <- seq(16, 17, 0.005)
    plot(the.interval, fromJSON(toJSON(wilkinson.20(the.interval))),  pch=20, cex=0.5,col='darkorange', main='Direct vs integer plus JSON round-trip polyomial evaluation')
    lines(the.interval, wilkinson.products(the.interval),   col='darkred')
    abline(h=0, col='grey')
    par(mar=c(4,2,0,2))
    plot(the.interval, fromJSON(toJSON(wilkinson.20(the.interval))) - wilkinson.products(the.interval),  pch=20, col='navy')
    text(17,0, 'JSON rounding errors', pos=2)
    abline(h=0, col='grey')
}




# Build a polynomial by multiplying a new (x - b) term
# poly.coefs [1 a_1 ... a_n]
# new.term    b
# product    [1 a_1*b a_2 + a_1*b ... a_n*b]
add.poly.term.int <- function(poly.coefs, new.term) {
  c(poly.coefs, 0L) + c(0L, -as.integer(new.term) * poly.coefs )   # once integer overflow occurs, returns NA.
}

# Same but dont restrict coefs to ints.  Rounding will occur
add.poly.term <- function(poly.coefs, new.term) {
  c(poly.coefs, 0L) + c(0L, -new.term * poly.coefs )   # once integer overflow occurs, returns NA.
}


prod.of.terms.aux <- function(coefs, root.l) {
  #cat(root.l[1], ',', length(root.l),' : ',coefs, '\n')
  if ( length(root.l) == 1) {
    return( coefs )
  } else {
    return(prod.of.terms.aux(add.poly.term(coefs, root.l[1]), root.l[-1]))
  }
}

###############################################################################################
# prod.of.terms
###############################################################################################
#
# n - number of terms of the form (x - k), k = 1..n to multiply
prod.of.terms <- function(n){
  prod.of.terms.aux(c(1L, -1L), 1+ seq(1, n))
}

#a vector of powers of x, computed recursively
powers.of.x <- function(x, n) {
    if (n == 0)
        return(1)  # the zeroth power of x
    else
        return(c(x * powers.of.x(x, n-1), 1))
}


###############################################################################################
# evaluate the Wilkinson Polynomial
###############################################################################################
#
# Use the computed coefficients and evaluate the polynomial
# eps - bias in coefficients.
eval.wilkinson  <- function(x, n, eps = 0) {
    coefs <- eps + prod.of.terms(n) * powers.of.x(x, n)
    sum(coefs)
}

# Same, but send the coefs on a json round-trip
eval.wilkinson.json  <- function(x, n) {
    coefs <- fromJSON(toJSON( prod.of.terms(n))) * powers.of.x(x, n)
    sum(coefs)
}

# Same, but send the coefs on a json round-trip
eval.wilkinson.buffers  <- function(x, n) {
  coefs <- unserialize_pb(serialize_pb( prod.of.terms(n), NULL)) * powers.of.x(x, n)
  sum(coefs)
}

# compare the json serialized roots with the internal values
wilkinson.errs.json <- function(the.range= 1:10, poly.degree=17) {
  errs <- abs(sapply(the.range, function(x)eval.wilkinson(x,poly.degree)) -
                sapply(the.range, function(x)eval.wilkinson.json(x,poly.degree)))
  list(the.range, errs)
}

# compare the protocol buffer serialized roots with the internal values
wilkinson.errs.pb <- function(the.range= 1:10, poly.degree=17) {
  errs <- abs(sapply(the.range, function(x)eval.wilkinson(x,poly.degree)) -
                sapply(the.range, function(x)eval.wilkinson.buffers(x,poly.degree)))
  list(the.range, errs)
}


# plot the errors in errors in the "round trip" evaluation for json and protocol buffers.
the.json.errs <- wilkinson.errs.json(1:20, 20)
plot(the.json.errs[[1]], the.json.errs[[2]], type='b', col='red', main='Round Trip Evaluation Errors')
the.pb.errs <- wilkinson.errs.pb(1:20, 20)
plot(the.pb.errs[[1]], the.pb.errs[[2]], type='b', col='red')


