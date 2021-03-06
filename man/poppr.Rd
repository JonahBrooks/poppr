\name{poppr}
\alias{poppr}
\title{Produce a basic summary table for population genetic analyses.}
\usage{
poppr(pop, total = TRUE, sublist = c("ALL"), blacklist = c(NULL),
  sample = 0, method = 1, missing = "ignore", cutoff = 0.05,
  quiet = FALSE, clonecorrect = FALSE, hier = c(1),
  dfname = "population_hierarchy", keep = 1, hist = TRUE, minsamp = 10)
}
\arguments{
  \item{pop}{a \code{\link{genind}} object OR any fstat,
  structure, genetix, genpop, or genalex formatted file.}

  \item{total}{default \code{TRUE}. Should indecies be
  calculated for the combined populations represented in
  the entire file?}

  \item{sublist}{a list of character strings or integers to
  indicate specific population names (located in
  \code{$pop.names} within the \code{\link{genind}} object)
  Defaults to "ALL".}

  \item{blacklist}{a list of character strings or integers
  to indicate specific populations to be removed from
  analysis. Defaults to NULL.}

  \item{sample}{an integer indicating the number of
  permutations desired to obtain p-values. Sampling will
  shuffle genotypes at each locus to simulate a panmictic
  population using the observed genotypes. Calculating the
  p-value includes the observed statistics, so set your
  sample number to one off for a round p-value (eg.
  \code{sample = 999} will give you p = 0.001 and
  \code{sample = 1000} will give you p = 0.000999001).}

  \item{method}{an integer from 1 to 4 indicating the
  method of sampling desired. see \code{\link{shufflepop}}
  for details.}

  \item{missing}{how should missing data be treated?
  \code{"zero"} and \code{"mean"} will set the missing
  values to those documented in \code{\link{na.replace}}.
  \code{"loci"} and \code{"geno"} will remove any loci or
  genotypes with missing data, respectively (see
  \code{\link{missingno}} for more information.}

  \item{cutoff}{\code{numeric} a number from 0 to 1
  indicating the percent missing data allowed for analysis.
  This is to be used in conjunction with the flag
  \code{missing} (see \code{\link{missingno}} for details)}

  \item{quiet}{Should the function print anything to the
  screen while it is performing calculations? \code{TRUE}
  prints nothing, \code{FALSE} (defualt) will print the
  population name and a progress bar.}

  \item{clonecorrect}{default \code{FALSE}. must be used
  with the \code{hier} and \code{dfname} parameters, or the
  user will potentially get undesiered results. see
  \code{\link{clonecorrect}} for details.}

  \item{hier}{a \code{numeric or character list}. This is
  the list of vectors within a data frame (specified in
  \code{dfname}) in the 'other' slot of the
  \code{\link{genind}} object. The list should indicate the
  population hierarchy to be used for clone correction.}

  \item{dfname}{a \code{character string}. This is the name
  of the data frame or list containing the vectors of the
  population hierarchy within the \code{other} slot of the
  \code{\link{genind}} object.}

  \item{keep}{an \code{integer}. This indicates the levels
  of the population hierarchy you wish to keep after clone
  correcting your data sets. To combine the hierarchy, just
  set keep from 1 to the length of your hierarchy. see
  \code{\link{clonecorrect}} for details.}

  \item{hist}{\code{logical} if \code{TRUE} a histogram
  will be produced for each population.}

  \item{minsamp}{an \code{integer} indicating the minimum
  number of individuals to resample for rarefaction
  analysis.}
}
\value{
\item{Pop}{A vector indicating the pouplation factor}
\item{N}{An integer vector indicating the number of
individuals/isolates in the specified population.}
\item{MLG}{An integer vector indicating the number of
multilocus genotypes found in the specified poupulation,
(see: \code{\link{mlg}})} \item{eMLG}{The expected number
of MLG at the lowest common sample size (set by the
parameter \code{minsamp}.} \item{SE}{The standard error for
the rarefaction analysis} \item{H}{Shannon-Weiner Diversity
index} \item{G}{Stoddard and Taylor's Index}
\item{Hexp}{Expected heterozygosity or Nei's 1987 genotypic
diversity corrected for sample size.} \item{E.5}{Evenness}
\item{Ia}{A numeric vector giving the value of the Index of
Association for each population factor, (see
\code{\link{ia}}).} \item{p.Ia}{A numeric vector indicating
the p-value for Ia from the number of reshufflings
indicated in \code{sample}. Lowest value is 1/n where n is
the number of observed values.} \item{rbarD}{A numeric
vector giving the value of the Standardized Index of
Association for each population factor, (see
\code{\link{ia}}).} \item{p.rD}{A numeric vector indicating
the p-value for rbarD from the number of reshufflings
indicated in \code{sample}. Lowest value is 1/n where n is
the number of observed values.} \item{File}{A vector
indicating the name of the original data file.}
}
\description{
This function allows the user to quickly view indecies of
distance, heterozygosity, and inbreeding to aid in the
decision of a path to further analyze a specified dataset.
It natively takes \code{\link{genind}} formatted files, but
can convert any raw data formats that adegenet can take
(fstat, structure, genetix, and genpop) as well as genalex
files exported into a csv format (see
\code{\link{read.genalex}} for details).
}
\note{
All values are rounded to three significant digits for the
final table.
}
\examples{
data(nancycats)
poppr(nancycats)

\dontrun{
poppr(nancycats, sample=99, total=FALSE, quiet=FALSE)

# Note: this is a larger data set that could take a couple of minutes to run
# on slower computers.
data(H3N2)
poppr(H3N2, total=FALSE, sublist=c("Austria", "China", "USA"),
				clonecorrect=TRUE, hier="country", dfname="x")
}
}
\author{
Zhian N. Kamvar
}
\references{
Paul-Michael Agapow and Austin Burt. Indices of multilocus
linkage disequilibrium. \emph{Molecular Ecology Notes},
1(1-2):101-102, 2001

A.H.D. Brown, M.W. Feldman, and E. Nevo. Multilocus
structure of natural populations of hordeum spontaneum.
\emph{Genetics}, 96(2):523-536, 1980.

Niklaus J. Gr\"unwald, Stephen B. Goodwin, Michael G.
Milgroom, and William E. Fry. Analysis of genotypic
diversity data for populations of microorganisms.
Phytopathology, 93(6):738-46, 2003

Bernhard Haubold and Richard R. Hudson. Lian 3.0: detecting
linkage disequilibrium in multilocus data. Bioinformatics,
16(9):847-849, 2000.

Kenneth L.Jr. Heck, Gerald van Belle, and Daniel
Simberloff. Explicit calculation of the rarefaction
diversity measurement and the determination of sufficient
sample size. Ecology, 56(6):pp. 1459-1461, 1975

S H Hurlbert. The nonconcept of species diversity: a
critique and alternative parameters. Ecology,
52(4):577-586, 1971.

J.A. Ludwig and J.F. Reynolds. Statistical Ecology. A
Primer on Methods and Computing. New York USA: John Wiley
and Sons, 1988.

Masatoshi Nei. Estimation of average heterozygosity and
genetic distance from a small number of individuals.
Genetics, 89(3):583-590, 1978.

Jari Oksanen, F. Guillaume Blanchet, Roeland Kindt, Pierre
Legendre, Peter R. Minchin, R. B. O'Hara, Gavin L. Simpson,
Peter Solymos, M. Henry H. Stevens, and Helene Wagner.
vegan: Community Ecology Package, 2012. R package version
2.0-5.

E.C. Pielou. Ecological Diversity. Wiley, 1975.

Claude Elwood Shannon. A mathematical theory of
communication. Bell Systems Technical Journal,
27:379-423,623-656, 1948

J M Smith, N H Smith, M O'Rourke, and B G Spratt. How
clonal are bacteria? Proceedings of the National Academy of
Sciences, 90(10):4384-4388, 1993.

J.A. Stoddart and J.F. Taylor. Genotypic diversity:
estimation and prediction in samples. Genetics,
118(4):705-11, 1988.
}
\seealso{
\code{\link{clonecorrect}}, \code{\link{poppr.all}},
\code{\link{ia}}, \code{\link{missingno}},
\code{\link{mlg}}
}

