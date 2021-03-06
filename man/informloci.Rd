\name{informloci}
\alias{informloci}
\title{Remove all non-phylogentically informative loci}
\usage{
informloci(pop, cutoff = 2/nInd(pop), quiet = FALSE)
}
\arguments{
  \item{pop}{a \code{\link{genind}} object.}

  \item{cutoff}{\code{numeric}. This is a number from 0 to
  1 representing the minimum percentage of differentiating
  individuals. Defaults is 2 individuals.}

  \item{quiet}{\code{logical}. When \code{quiet = TRUE},
  messages indicating the loci removed will be printed to
  screen. When \code{quiet = FALSE}, nothing will be
  printed to screen.}
}
\value{
A \code{genind} object with user-defined informative loci.
}
\description{
This function will facilitate in removing phylogenetically
uninformative loci from a \code{\link{genind}} object. The
user can specify what is meant by phylogenetically
uninformative with a specification of the cutoff
percentage. Any loci under the cutoff will be removed. For
convenience's sake, the default cutoff is set to 2
individuals.
}
\note{
This will have a few side effects that affect certain
analyses. First, the number of multilocus genotypes might
be reduced due to the reduced number of markers. Second, if
you plan on using this data for analysis of the index of
association, be sure to use the standardized version
(rbarD) that corrects for the number of observed loci.
}
\examples{
# Load the data set H3N2
data(H3N2)
pop(H3N2) <- H3N2$other$x$country
Nepal <- popsub(H3N2, "Nepal")

# Using the default 2 individuals.
N.inform <- informloci(Nepal)

# 5 individuals.
N.informfive <- informloci(Nepal, cutoff = 5/nInd(Nepal))

# 10 individuals. Too many. Gives warning.
N.informten <- informloci(Nepal, cutoff = 10/nInd(Nepal))

# Decimate (10\%)
N.informdecimated <- informloci(Nepal, cutoff = 0.1)
}

