\name{greycurve}
\alias{greycurve}
\title{Display a greyscale gradient adjusted to specific parameters}
\usage{
greycurve(glim = c(0, 0.8), gadj = 3, gweight = 1)
}
\arguments{
  \item{glim}{"grey limit". Two numbers between zero and
  one. They determine the upper and lower limits for the
  \code{\link{gray}} function. Default is 0 (black) and 0.8
  (20\% black).}

  \item{gadj}{"grey adjust". a positive \code{integer}
  greater than zero that will serve as the exponent to the
  edge weight to scale the grey value to represent that
  weight.}

  \item{gweight}{"grey weight". an \code{integer}. If it's
  1, the grey scale will be weighted to emphasize the
  differences between closely related nodes. If it is 2,
  the grey scale will be weighted to emphasize the
  differences between more distantly related nodes.}
}
\value{
A plot displaying a grey gradient from 0.001 to 1 with
minimum and maximum values displayed as yellow lines, and
an equation for the correction displayed in red.
}
\description{
This function has one purpose. It is for deciding the
appropriate scaling for a grey palette to be used for edge
weights of a minimum spanning network.
}
\examples{
# Normal grey curve with an adjustment of 3, an upper limit of 0.8, and
# weighted towards smaller values.
greycurve()
\dontrun{
# 1:1 relationship grey curve.
greycurve(gadj=1, glim=1:0)

# Grey curve weighted towards larger values.
greycurve(gweight=2)

# Same as the first, but the limit is 1.
greycurve(glim=1:0)

# Setting the lower limit to 0.1 and weighting towards larger values.
greycurve(glim=c(0.1,0.8), gweight=2)
}
}
\author{
Zhian N. Kamvar
}

