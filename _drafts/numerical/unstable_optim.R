# penalty optimization
# distributed example, looking for instabilities
# JMA 8 Aug 2017

#library(optimr)   # just use base::optim
objective <- function(x,y,h=1) {
  f <- 0
  if (x <= 0 || x>= 1)
    f <- h
  if (y<= 0 || y>= 1)
    f <- h 
  f
}

penalty <- function(z, th=1) {
  z <- th* exp(z * th)
  z
}

x <- seq(from=-0.1, to=1.1, by= 0.1)
?seq

constrained_obj <- function(x,y, th) {
  f <- objective(x,y)
  f <- penalty(x) + 2*penalty(1-x) + penalty(y) + 2*penalty(1-y)
}

plot(x, constrained_obj(x,0.5, th=3))

optim(c(0.5,0.5), constrained_obj, gr = NULL, th=3,
      method =  "BFGS")
