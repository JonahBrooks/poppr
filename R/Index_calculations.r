#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#
# This software was authored by Zhian N. Kamvar and Javier F. Tabima, graduate 
# students at Oregon State University; and Dr. Nik Grünwald, an employee of 
# USDA-ARS.
#
# Permission to use, copy, modify, and distribute this software and its
# documentation for educational, research and non-profit purposes, without fee, 
# and without a written agreement is hereby granted, provided that the statement
# above is incorporated into the material, giving appropriate attribution to the
# authors.
#
# Permission to incorporate this software into commercial products may be
# obtained by contacting USDA ARS and OREGON STATE UNIVERSITY Office for 
# Commercialization and Corporate Development.
#
# The software program and documentation are supplied "as is", without any
# accompanying services from the USDA or the University. USDA ARS or the 
# University do not warrant that the operation of the program will be 
# uninterrupted or error-free. The end-user understands that the program was 
# developed for research purposes and is advised not to rely exclusively on the 
# program for any reason.
#
# IN NO EVENT SHALL USDA ARS OR OREGON STATE UNIVERSITY BE LIABLE TO ANY PARTY 
# FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING
# LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, 
# EVEN IF THE OREGON STATE UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF 
# SUCH DAMAGE. USDA ARS OR OREGON STATE UNIVERSITY SPECIFICALLY DISCLAIMS ANY 
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AND ANY STATUTORY 
# WARRANTY OF NON-INFRINGEMENT. THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS"
# BASIS, AND USDA ARS AND OREGON STATE UNIVERSITY HAVE NO OBLIGATIONS TO PROVIDE
# MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS. 
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#==============================================================================#
# The calculation of the Index of Association and standardized Index of 
# Association.
#'
#' Produce a basic summary table for population genetic analyses.
#'
#' This function allows the user to quickly view indecies of distance, 
#' heterozygosity, and inbreeding to aid in the decision of a path to further
#' analyze a specified dataset. It natively takes \code{\link{genind}} formatted
#' files, but can convert any raw data formats that adegenet can take (fstat,
#' structure, genetix, and genpop) as well as genalex files exported into a csv 
#' format (see \code{\link{read.genalex}} for details).
#'
#'
#' @param pop a \code{\link{genind}} object OR any fstat, structure, genetix, 
#' genpop, or genalex formatted file.
#'
#' @param total default \code{TRUE}. Should indecies be calculated for the 
#' combined populations represented in the entire file?
#' 
#' @param sublist a list of character strings or integers to indicate specific 
#' population names (located in \code{$pop.names} within the 
#' \code{\link{genind}} object) Defaults to "ALL".
#'
#' @param blacklist a list of character strings or integers to indicate specific
#' populations to be removed from analysis. Defaults to NULL.
#' 
#' @param sample an integer indicating the number of permutations desired to
#' obtain p-values. Sampling will shuffle genotypes at each locus to simulate
#' a panmictic population using the observed genotypes. Calculating the p-value
#' includes the observed statistics, so set your sample number to one off for a
#' round p-value (eg. \code{sample = 999} will give you p = 0.001 and
#' \code{sample = 1000} will give you p = 0.000999001). 
#'
#' @param method an integer from 1 to 4 indicating the method of sampling desired.
#' see \code{\link{shufflepop}} for details.
#' 
#' @param missing how should missing data be treated? \code{"zero"} and 
#' \code{"mean"} will set the missing values to those documented in 
#' \code{\link{na.replace}}. \code{"loci"} and \code{"geno"} will remove any 
#' loci or genotypes with missing data, respectively (see 
#' \code{\link{missingno}} for more information.
#' 
#' @param cutoff \code{numeric} a number from 0 to 1 indicating the percent
#' missing data allowed for analysis. This is to be used in conjunction with the
#' flag \code{missing} (see \code{\link{missingno}} for details)
#' 
#' @param quiet Should the function print anything to the screen while it is
#' performing calculations? \code{TRUE} prints nothing, 
#' \code{FALSE} (defualt) will print the population name and a progress bar.
#' 
#' @param clonecorrect default \code{FALSE}.
#' must be used with the \code{hier} and \code{dfname} parameters, or the user
#' will potentially get undesiered results. see \code{\link{clonecorrect}} for
#' details. 
#' 
#' @param hier a \code{numeric or character list}. This is the list of vectors
#' within a data frame (specified in \code{dfname}) in the 'other' slot of the
#' \code{\link{genind}} object. The list should indicate the population
#' hierarchy to be used for clone correction.
#'
#' @param dfname a \code{character string}. This is the name of the data frame
#' or list containing the vectors of the population hierarchy within the
#' \code{other} slot of the \code{\link{genind}} object.
#' 
#' @param keep an \code{integer}. This indicates the levels of the population
#' hierarchy you wish to keep after clone correcting your data sets. To combine
#' the hierarchy, just set keep from 1 to the length of your hierarchy. see
#' \code{\link{clonecorrect}} for details. 
#' 
#' @param hist \code{logical} if \code{TRUE} a histogram will be produced for
#' each population. 
#' 
#' @param minsamp an \code{integer} indicating the minimum number of individuals
#' to resample for rarefaction analysis. 
#'
#' @return 
#' \item{Pop}{A vector indicating the pouplation factor}
#' \item{N}{An integer vector indicating the number of individuals/isolates in
#' the specified population.}
#' \item{MLG}{An integer vector indicating the number of multilocus genotypes
#' found in the specified poupulation, (see: \code{\link{mlg}})}
#' \item{eMLG}{The expected number of MLG at the lowest common sample size (set
#' by the parameter \code{minsamp}.}
#' \item{SE}{The standard error for the rarefaction analysis}
#' \item{H}{Shannon-Weiner Diversity index}
#' \item{G}{Stoddard and Taylor's Index}
#' \item{Hexp}{Expected heterozygosity or Nei's 1987 genotypic diversity corrected for sample size.}
#' \item{E.5}{Evenness}
#' \item{Ia}{A numeric vector giving the value of the Index of Association for
#' each population factor, (see \code{\link{ia}}).}
#' \item{p.Ia}{A numeric vector indicating the p-value for Ia from the
#' number of reshufflings indicated in \code{sample}. Lowest value is 1/n where
#' n is the number of observed values.}
#' \item{rbarD}{A numeric vector giving the value of the Standardized Index of
#' Association for each population factor, (see \code{\link{ia}}).}
#' \item{p.rD}{A numeric vector indicating the p-value for rbarD from the
#' number of reshufflings indicated in \code{sample}. Lowest value is 1/n where
#' n is the number of observed values.}
#' \item{File}{A vector indicating the name of the original data file.}
#'
#' @note All values are rounded to three significant digits for the final table.
#' 
#' @seealso \code{\link{clonecorrect}}, \code{\link{poppr.all}}, 
#' \code{\link{ia}}, \code{\link{missingno}}, \code{\link{mlg}}
#'
#' @export
#' @author Zhian N. Kamvar
#' @references  Paul-Michael Agapow and Austin Burt. Indices of multilocus 
#' linkage disequilibrium. \emph{Molecular Ecology Notes}, 1(1-2):101-102, 2001
#' 
#' A.H.D. Brown, M.W. Feldman, and E. Nevo. Multilocus structure of natural 
#' populations of hordeum spontaneum. \emph{Genetics}, 96(2):523-536, 1980.
#'
#' Niklaus J. Gr\"unwald, Stephen B. Goodwin, Michael G. Milgroom, and William E. Fry.
#' Analysis of genotypic diversity data for populations of microorganisms. 
#' Phytopathology, 93(6):738-46, 2003
#'
#' Bernhard Haubold and Richard R. Hudson. Lian 3.0: detecting linkage disequilibrium
#' in multilocus data. Bioinformatics, 16(9):847-849, 2000.
#'
#' Kenneth L.Jr. Heck, Gerald van Belle, and Daniel Simberloff. Explicit calculation
#' of the rarefaction diversity measurement and the determination of sufficient sample
#' size. Ecology, 56(6):pp. 1459-1461, 1975
#'
#' S H Hurlbert. The nonconcept of species diversity: a critique and alternative 
#' parameters. Ecology, 52(4):577-586, 1971.
#'
#' J.A. Ludwig and J.F. Reynolds. Statistical Ecology. A Primer on Methods and 
#' Computing. New York USA: John Wiley and Sons, 1988.
#'
#' Masatoshi Nei. Estimation of average heterozygosity and genetic distance from 
#' a small number of individuals. Genetics, 89(3):583-590, 1978.
#'
#' Jari Oksanen, F. Guillaume Blanchet, Roeland Kindt, Pierre Legendre, Peter R.
#' Minchin, R. B. O'Hara, Gavin L. Simpson, Peter Solymos, M. Henry H. Stevens, 
#' and Helene Wagner. vegan: Community Ecology Package, 2012. R package version 2.0-5. 
#'
#' E.C. Pielou. Ecological Diversity. Wiley, 1975.
#'
#' Claude Elwood Shannon. A mathematical theory of communication. Bell Systems 
#' Technical Journal, 27:379-423,623-656, 1948
#'
#' J M Smith, N H Smith, M O'Rourke, and B G Spratt. How clonal are bacteria?
#' Proceedings of the National Academy of Sciences, 90(10):4384-4388, 1993.
#'
#' J.A. Stoddart and J.F. Taylor. Genotypic diversity: estimation and prediction
#' in samples. Genetics, 118(4):705-11, 1988.
#'
#'
#' @examples
#' data(nancycats)
#' poppr(nancycats)
#' 
#' \dontrun{
#' poppr(nancycats, sample=99, total=FALSE, quiet=FALSE)
#' 
#' # Note: this is a larger data set that could take a couple of minutes to run
#' # on slower computers. 
#' data(H3N2)
#' poppr(H3N2, total=FALSE, sublist=c("Austria", "China", "USA"), 
#' 				clonecorrect=TRUE, hier="country", dfname="x")
#' }
#==============================================================================#
#' @import adegenet pegas ggplot2 vegan
poppr <- function(pop,total=TRUE, sublist=c("ALL"), blacklist=c(NULL), sample=0,
                  method=1, missing="ignore", cutoff=0.05, quiet=FALSE,
                  clonecorrect=FALSE, hier=c(1), dfname="population_hierarchy", 
                  keep = 1, hist=TRUE, minsamp=10){
  METHODS = c("permute alleles", "parametric bootstrap",
              "non-parametric bootstrap", "multilocus")
  x <- .file.type(pop, missing=missing, cutoff=cutoff, clonecorrect=clonecorrect, 
                  hier=hier, dfname=dfname, keep=keep, quiet=TRUE)  
  # The namelist will contain information such as the filename and population
  # names so that they can easily be ported around.
  namelist <- NULL
  callpop  <- match.call()
  if(!is.na(grep("system.file", callpop)[1])){
    popsplt <- unlist(strsplit(pop, "/"))
    namelist$File <- popsplt[length(popsplt)]
  }
  else if(is.genind(pop)){
    namelist$File <- x$X
  }
  else{
    namelist$File <- basename(x$X)
  }
  #poplist <- x$POPLIST
  if(toupper(sublist[1]) == "TOTAL" & length(sublist) == 1){
    pop           <- x$GENIND
    pop(pop)      <- NULL
    poplist       <- NULL
    poplist$Total <- pop
  }
  else{
    pop <- popsub(x$GENIND, sublist=sublist, blacklist=blacklist)
    if (any(levels(pop(pop)) == "")){
      levels(pop(pop))[levels(pop(pop)) == ""] <- "?"
      warning("missing population factor replaced with '?'")
    }
    poplist <- .pop.divide(pop)
  }
  # Creating the genotype matrix for vegan's diversity analysis.
  pop.mat <- mlg.matrix(pop)
  if (total==TRUE & !is.null(poplist) & length(poplist) > 1){
    poplist$Total <- pop
    pop.mat <- rbind(pop.mat, colSums(pop.mat))
  }
  sublist <- names(poplist)
  Iout    <- NULL
  result  <- NULL
  origpop <- x$GENIND
  rm(x)
  total   <- toupper(total)
  missing <- toupper(missing)
  type    <- pop@type
  # For presence/absences markers, a different algorithm is applied. 
  if(type=="PA"){
    .Ia.Rd <- .PA.Ia.Rd
  }
  if (is.null(poplist)){
    MPI <- NULL
  }
  else{
    MPI <- 1
  }
  if (!is.null(MPI)){
    MLG.vec <- vapply(sublist, function(x) mlg(poplist[[x]], quiet=TRUE), 1)
    N.vec   <- vapply(sublist, function(x) length(poplist[[x]]@ind.names), 1)
    # Shannon-Weiner diversity index.
    H       <- vegan::diversity(pop.mat)
    # inverse Simpson's index aka Stoddard and Taylor: 1/lambda
    G       <- vegan::diversity(pop.mat, "inv")
    Hexp    <- (N.vec/(N.vec-1))*vegan::diversity(pop.mat, "simp")
    # E_5
    E.5     <- (G-1)/(exp(H)-1)
    # rarefaction giving the standard errors. This will use the minimum pop size
    # above a user-defined threshold.
    raremax <- ifelse(is.null(nrow(pop.mat)), sum(pop.mat), 
                      ifelse(min(rowSums(pop.mat)) > minsamp, 
                             min(rowSums(pop.mat)), minsamp))
    
    N.rare <- suppressWarnings(rarefy(pop.mat, raremax, se=TRUE))
    IaList <- NULL
    invisible(lapply(sublist, function(x) 
      IaList <<- rbind(IaList, 
                       .ia(poplist[[x]], 
                           sample=sample, 
                           method=method, 
                           quiet=quiet, 
                           missing=missing, 
                           namelist=list(File=namelist$File, population = x),
                           hist=hist
                       ))))

    Iout <- as.data.frame(list(Pop=sublist, N=N.vec, MLG=MLG.vec, 
                               eMLG=round(N.rare[1, ], 3), 
                               SE=round(N.rare[2, ], 3), 
                               H=round(H, 3), 
                               G=round(G,3),
                               Hexp=round(Hexp, 3),
                               E.5=round(E.5,3),
                               round(IaList, 3),
                               File=namelist$File))
    rownames(Iout) <- NULL
    return(final(Iout, result))
  } else { 
    MLG.vec <- mlg(pop, quiet=TRUE)
    N.vec <- length(pop@ind.names)
    # Shannon-Weiner diversity index.
    H <- vegan::diversity(pop.mat)
    # E_1, Pielou's evenness.
    # J <- H / log(rowSums(pop.mat > 0))
    # inverse Simpson's index aka Stoddard and Taylor: 1/lambda
    G <- vegan::diversity(pop.mat, "inv")
    Hexp <- (N.vec/(N.vec-1))*vegan::diversity(pop.mat, "simp")
    # E_5
    E.5 <- (G-1)/(exp(H)-1)
    # rarefaction giving the standard errors. No population structure means that
    # the sample is equal to the number of individuals.
    N.rare <- rarefy(pop.mat, sum(pop.mat), se=TRUE)
    IaList <- .ia(pop, sample=sample, method=method, quiet=quiet, missing=missing,
                  namelist=(list(File=namelist$File, population="Total")),
                  hist=hist)
    Iout <- as.data.frame(list(Pop="Total", N=N.vec, MLG=MLG.vec, 
                               eMLG=round(N.rare[1, ], 3), 
                               SE=round(N.rare[2, ], 3),
                               H=round(H, 3), 
                               G=round(G,3), 
                               Hexp=round(Hexp, 3), 
                               E.5=round(E.5,3), 
                               round(as.data.frame(t(IaList)), 3),
                               File=namelist$File))
    rownames(Iout) <- NULL
    return(final(Iout, result))
  }
}

#==============================================================================#
# This will process a list of files given by filelist
#' Process a list of files with poppr
#'
#' poppr.all is a wrapper function that will loop through a list of files from
#' the workind directory, execute \code{\link{poppr}}, and concatenate the
#' output into one data frame.
#'
#' @param filelist a list of files in the current working directory
#'
#' @param ... arguments passed on to poppr
#'
#' @return see \code{\link{poppr}}
#'
#' @seealso \code{\link{poppr}}, \code{\link{getfile}}
#' @export
#' @author Zhian N. Kamvar
#' @examples
#' \dontrun{
#' # Obtain a list of fstat files from a directory.
#' x <- getfile(multi=TRUE, pattern="^.+?dat$")
#'
#' # set the working directory to that directory.
#' setwd(x$path)
#'
#' # run the analysis on each file.
#' poppr.all(x$files)
#' }
#==============================================================================# 
poppr.all <- function(filelist, ...) {
	result <- NULL
	for(a in filelist){
    cat("| File: ",basename(a),"\n")
		result <- rbind(result, poppr(a, ...))
	}
	return(result)
}
#==============================================================================#
# 
# This will now calculate the index of associaton and also perform the necessary
# permutation analysis, printing out a table of raw information. 
#
#' Index of Association
#' 
#' Calculate the Index of Association and Standardized Index of Association.
#' Obtain p-values from one-sided permutation tests. 
#' 
#' @param pop a \code{\link{genind}} object OR any fstat, structure, genetix, 
#' genpop, or genalex formatted files.
#'
#' @param sample an integer indicating the number of permutations desired (eg
#' 999).
#'
#' @param method an integer from 1 to 4 indicating the sampling method desired.
#' see \code{\link{shufflepop}} for details. 
#'
#' @param quiet Should the function print anything to the screen while it is
#' performing calculations? 
#'
#' \code{TRUE} prints nothing.
#'
#' \code{FALSE} (defualt) will print the population name and progress bar.
#'
#' @param missing a character string. see \code{\link{missingno}} for details.
#'
#' @param hist \code{logical} if \code{TRUE}, a histogram will be printed for
#' each population if there is sampling.
#'
#' @return 
#' \emph{If no sampling has occured:}
#' 
#' A named number vector of length 2 giving the Index of Association,
#' "Ia"; and the Standardized Index of Association, "rbarD"
#'
#' \emph{If there is sampling:}
#'
#' A a named number vector of length 4 with the following values:
#' \item{Ia}{numeric. The index of association.}
#' \item{p.Ia}{A number indicating the p-value resulting from a one-sided
#' permutation test based on the number of samples indicated in the original
#' call.}
#' \item{rbarD}{numeric. The standardized index of association.}
#' \item{p.rD}{A factor indicating the p-value resutling from a one-sided
#' permutation test based on the number of samples indicated in the original
#' call.}
#'
#' @references  Paul-Michael Agapow and Austin Burt. Indices of multilocus 
#' linkage disequilibrium. \emph{Molecular Ecology Notes}, 1(1-2):101-102, 2001
#' 
#' A.H.D. Brown, M.W. Feldman, and E. Nevo. Multilocus structure of natural 
#' populations of hordeum spontaneum. \emph{Genetics}, 96(2):523-536, 1980.
#'
#' J M Smith, N H Smith, M O'Rourke, and B G Spratt. How clonal are bacteria?
#' Proceedings of the National Academy of Sciences, 90(10):4384-4388, 1993.
#'
#' @seealso \code{\link{poppr}}, \code{\link{missingno}},
#' \code{\link{import2genind}},
#' \code{\link{read.genalex}}, \code{\link{clonecorrect}}
#' 
#' @export
#' @author Zhian N. Kamvar
#' @examples
#' data(nancycats)
#' ia(nancycats)
#' 
#' \dontrun{
#' # Get the index for each population.
#' lapply(seppop(nancycats), ia)
#' # With sampling
#' lapply(seppop(nancycats), ia, sample=999)
#' }
#==============================================================================#

ia <- function(pop, sample=0, method=1, quiet=FALSE, missing="ignore", 
                hist=TRUE){
  METHODS = c("permute alleles", "parametric bootstrap",
              "non-parametric bootstrap", "multilocus")
  
  namelist            <- NULL
  namelist$population <- ifelse(length(levels(pop@pop)) > 1 | 
                                is.null(pop@pop), "Total", pop@pop.names)
  namelist$File       <- as.character(pop@call[2])
  
  popx    <- pop
  missing <- toupper(missing)
  type    <- pop@type
  
  if(type=="PA"){
    .Ia.Rd <- .PA.Ia.Rd
  }
  else {
    popx <- seploc(popx)
  }

  # if there are less than three individuals in the population, the calculation
  # does not proceed. 
  if (nInd(pop) < 3){
    IarD <- as.numeric(c(NA,NA))
    names(IarD) <- c("Ia", "rbarD")
    if(sample==0){
      return(IarD)
    }
    else{
      IarD <- as.numeric(rep(NA,4))
      names(IarD) <- c("Ia","p.Ia","rbarD","p.rD")
      return(IarD)
    }
  }
  
  IarD <- .Ia.Rd(popx, missing)
  names(IarD) <- c("Ia", "rbarD")
  # no sampling, it will simply return two named numbers.
  if (sample==0){
    Iout   <- IarD
    result <- NULL
  }
  # sampling will perform the iterations and then return a data frame indicating
  # the population, index, observed value, and p-value. It will also produce a 
  # histogram.
  else{
    Iout     <- NULL 
    idx      <- as.data.frame(list(Index=names(IarD)))
    samp     <- .sampling(popx, sample, missing, quiet=quiet, type=type, method=method)
    samp2    <- rbind(samp, IarD)
    p.val    <- ia.pval(index="Ia", samp2, IarD[1])
    p.val[2] <- ia.pval(index="rbarD", samp2, IarD[2])
    if(hist == TRUE){
      poppr.plot(samp, observed=IarD, pop=namelist$population,
                        file=namelist$File, pval=p.val, N=nrow(pop@tab))
    }
    result         <- 1:4
    result[c(1,3)] <- IarD
    result[c(2,4)] <- p.val
    names(result)  <- c("Ia","p.Ia","rbarD","p.rD")
  }  
  return(final(Iout, result))
}

