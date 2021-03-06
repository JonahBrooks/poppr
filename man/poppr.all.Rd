\name{poppr.all}
\alias{poppr.all}
\title{Process a list of files with poppr}
\usage{
poppr.all(filelist, ...)
}
\arguments{
  \item{filelist}{a list of files in the current working
  directory}

  \item{...}{arguments passed on to poppr}
}
\value{
see \code{\link{poppr}}
}
\description{
poppr.all is a wrapper function that will loop through a
list of files from the workind directory, execute
\code{\link{poppr}}, and concatenate the output into one
data frame.
}
\examples{
\dontrun{
# Obtain a list of fstat files from a directory.
x <- getfile(multi=TRUE, pattern="^.+?dat$")

# set the working directory to that directory.
setwd(x$path)

# run the analysis on each file.
poppr.all(x$files)
}
}
\author{
Zhian N. Kamvar
}
\seealso{
\code{\link{poppr}}, \code{\link{getfile}}
}

