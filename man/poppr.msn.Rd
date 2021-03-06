\name{poppr.msn}
\alias{poppr.msn}
\title{Create a minimum spanning network of selected populations using a distance
matrix.}
\usage{
poppr.msn(pop, distmat, palette = topo.colors, sublist = "All",
  blacklist = NULL, vertex.label = "MLG", gscale = TRUE, glim = c(0,
  0.8), gadj = 3, gweight = 1, wscale = TRUE, ...)
}
\arguments{
  \item{pop}{a \code{\link{genind}} object}

  \item{distmat}{a distance matrix that has been derived
  from your data set.}

  \item{palette}{a \code{function} defining the color
  palette to be used to color the populations on the graph.
  It defaults to \code{\link{topo.colors}}, but you can
  easily create new schemes by using
  \code{\link{colorRampPalette}} (see examples for
  details)}

  \item{sublist}{a \code{vector} of population names or
  indexes that the user wishes to keep. Default to "ALL".}

  \item{blacklist}{a \code{vector} of population names or
  indexes that the user wishes to discard. Default to
  \code{NULL}}

  \item{vertex.label}{a \code{vector} of characters to
  label each vertex. There are two defaults: \code{"MLG"}
  will label the nodes with the multilocus genotype from
  the original data set and \code{"inds"} will label the
  nodes with the representative individual names.}

  \item{gscale}{"grey scale". If this is \code{TRUE}, this
  will scale the color of the edges proportional to the
  observed distance, with the lines becoming darker for
  more related nodes. See \code{\link{greycurve}} for
  details.}

  \item{glim}{"grey limit". Two numbers between zero and
  one. They determine the upper and lower limits for the
  \code{\link{gray}} function. Default is 0 (black) and 0.8
  (20\% black). See \code{\link{greycurve}} for details.}

  \item{gadj}{"grey adjust". a positive \code{integer}
  greater than zero that will serve as the exponent to the
  edge weight to scale the grey value to represent that
  weight. See \code{\link{greycurve}} for details.}

  \item{gweight}{"grey weight". an \code{integer}. If it's
  1, the grey scale will be weighted to emphasize the
  differences between closely related nodes. If it is 2,
  the grey scale will be weighted to emphasize the
  differences between more distantly related nodes. See
  \code{\link{greycurve}} for details.}

  \item{wscale}{"width scale". If this is \code{TRUE}, the
  edge widths will be scaled proportional to the inverse of
  the observed distance , with the lines becoming thicker
  for more related nodes.}

  \item{...}{any other arguments that could go into
  plot.igraph}
}
\value{
\item{graph}{a minimum spanning network with nodes
corresponding to MLGs within the data set. Colors of the
nodes represent population membership. Width and color of
the edges represent distance.} \item{populations}{a vector
of the population names corresponding to the vertex colors}
\item{colors}{a vector of the hexadecimal representations
of the colors used in the vertex colors}
}
\description{
Create a minimum spanning network of selected populations
using a distance matrix.
}
\note{
The edges of these graphs may cross each other if the graph
becomes too large.
}
\examples{
# Load the data set and calculate the distance matrix for all individuals.
data(Aeut)
A.dist <- diss.dist(Aeut)

# Graph it.
A.msn <- poppr.msn(Aeut, A.dist, gadj=15, vertex.label=NA)

\dontrun{
# Set subpopulation structure.
Aeut.sub <- splitcombine(Aeut, method=2, hier=c("Pop", "Subpop"))

# Plot respective to the subpopulation structure
As.msn <- poppr.msn(Aeut.sub, A.dist, gadj=15, vertex.label=NA)

# Show only the structure of the Athena population.
As.msn <- poppr.msn(Aeut.sub, A.dist, gadj=15, vertex.label=NA, sublist=1:10)

# Let's look at the structure of the microbov data set
data(microbov)
micro.dist <- diss.dist(microbov)
micro.msn <- poppr.msn(microbov, diss.dist(microbov), vertex.label=NA)

Let's plot it and show where individuals have < 15\% of their genotypes
different.

plot.igraph(micro.msn$graph, edge.label = ifelse(E(micro.msn$graph)$weight < 0.15,
round(E(micro.msn$graph)$weight, 3), NA), vertex.size=2, edge.label.color="red")

}
}
\author{
Javier F. Tabima, Zhian N. Kamvar
}
\seealso{
\code{\link{nancycats}}, \code{\link{upgma}},
\code{\link{nj}}, \code{\link{nodelabels}},
\code{\link{na.replace}}, \code{\link{missingno}},
\code{\link{bruvo.msn}}, \code{\link{greycurve}}.
}

