\name{mlg}
\alias{mlg}
\alias{mlg.crosspop}
\alias{mlg.table}
\alias{mlg.vector}
\title{Create counts, vectors, and matrices of multilocus genotypes.}
\usage{
mlg(pop, quiet = FALSE)

mlg.table(pop, sublist = "ALL", blacklist = NULL, mlgsub = NULL,
  bar = TRUE, total = FALSE, quiet = FALSE)

mlg.vector(pop)

mlg.crosspop(pop, sublist = "ALL", blacklist = NULL, mlgsub = NULL,
  indexreturn = FALSE, df = FALSE, quiet = FALSE)
}
\arguments{
  \item{pop}{a \code{\link{genind}} object.}

  \item{sublist}{a \code{vector} of population names or
  indices that the user wishes to keep. Default to "ALL".}

  \item{blacklist}{a \code{vector} of population names or
  indices that the user wishes to discard. Default to
  \code{NULL}.}

  \item{mlgsub}{a \code{vector} of multilocus genotype
  indices with which to subset \code{mlg.table} and
  \code{mlg.crosspop}. NOTE: The resulting table from
  \code{mlg.table} will only contain countries with those
  MLGs}

  \item{quiet}{\code{Logical}. If FALSE, progress of
  functions will be printed to the screen.}

  \item{bar}{\code{logical} If \code{TRUE}, a bar graph for
  each population will be displayed showing the relative
  abundance of each MLG within the population.}

  \item{indexreturn}{\code{logical} If \code{TRUE}, a
  vector will be returned to index the columns of
  \code{mlg.table}.}

  \item{df}{\code{logical} If \code{TRUE}, return a data
  frame containing the counts of the MLGs and what
  countries they are in. Useful for making graphs with
  \code{\link{ggplot}}.}

  \item{total}{\code{logical} If \code{TRUE}, a row
  containing the sum of all represented MLGs is appended to
  the matrix produced by mlg.table.}
}
\value{
an integer of the number of multilocus genotypes within the
sample.

a matrix with columns indicating unique multilocus
genotypes and rows indicating populations.

a numeric vector naming the multilocus genotype of each
individual in the dataset.

a \code{list} containing vectors of population names for
each MLG.
}
\description{
Create counts, vectors, and matrices of multilocus
genotypes.
}
\note{
The resulting matrix of \code{mlg.table} can be used for
analysis with the \code{\link{vegan}} package. The names of
the multilocus genotypes represented will be those from the
entire dataset. If you wish to view those relative to a
subsetted dataset, you can use \code{mlg.bar(popsub(pop,
...))}.

The numbers of \code{mlg.vector} will not match up with the
sequence of new genotypes found because sorting takes place
within the algorithm before the genotypes are called so
that the number of comparisons is \eqn{n-1} instead of
\eqn{\frac{n(n-1)}{2}}.
}
\examples{
data(H3N2)
mlg(H3N2, quiet=FALSE)

H.vec <- mlg.vector(H3N2)

# Changing the population vector to indicate the years of each epidemic.
pop(H3N2) <- other(H3N2)$x$country
H.tab <- mlg.table(H3N2, bar=FALSE, total=TRUE)

# Show which genotypes exist accross populations in the entire dataset.
res <- mlg.crosspop(H3N2, quiet=FALSE)

\dontrun{
# Let's say we want to visualize the multilocus genotype distribution for the
# USA and Russia
mlg.table(H3N2, sublist=c("USA", "Russia"), bar=TRUE)

# An exercise in subsetting the output of mlg.table and mlg.vector.
# First, get the indices of each MLG duplicated across populations.
inds <- mlg.crosspop(H3N2, quiet=FALSE, indexreturn=TRUE)

# Since the columns of the table from mlg.table are equal to the number of
# MLGs, we can subset with just the columns.
H.sub <- H.tab[, inds]

# We can also do the same by using the mlgsub flag.
H.sub <- mlg.table(H3N2, mlgsub=inds)

# We can subset the original data set using the output of mlg.vector to
# analyze only the MLGs that are duplicated across populations.
new.H <- H3N2[H.vec \%in\% inds, ]

# A simple example. 10 individuals, 5 genotypes.
mat1 <- matrix(ncol=5, 25:1)
mat1 <- rbind(mat1, mat1)
mat <- matrix(nrow=10, ncol=5, paste(mat1,mat1,sep="/"))
mat.gid <- df2genind(mat, sep="/")
mlg(mat.gid)
mlg.vector(mat.gid)
mlg.table(mat.gid)
}
}
\author{
Zhian N. Kamvar
}
\seealso{
\code{\link{diversity}} \code{\link{popsub}}
}

