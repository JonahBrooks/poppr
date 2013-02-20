Poppr is an R package designed for analysis of populations with mixed modes of 
sexual and clonal reproduction. It is built around the framework of adegenet's
genind object and offers the following implementations:

- Calculate the index of association and standardized index of association
- Calculate Bruvo's distance (implemented in C for speed)
- Automatically clone-censor data sets based on a population hierarchy.
- Define multilocus genotypes
- Create multilocus genotype tables for analysis with the package, vegan.
- Quickly analyze what multilocus genotypes cross populations. 
- Visualizing Bruvo's distance as a minimum spanning multilocus genotype network.

To install this package, make sure you have the following:

- devtools (to install, use: `install.packages("devtools")`)
- Xcode (OSX)
- Rtools (Windows)

Now you can use the `install_github()` function:

    library(devtools)

    install_github("poppr", "poppr")
	
    library(poppr)

You can view the manual by typing: `vignette("poppr_manual")`
	
Enjoy!

This software was authored by Zhian N. Kamvar and Javier F. Tabima, graduate 
students at Oregon State University; and Dr. Nik Grünwald, an employee of 
USDA-ARS.

Permission to use, copy, modify, and distribute this software and its
documentation for educational, research and non-profit purposes, without fee, 
and without a written agreement is hereby granted, provided that the statement
above is incorporated into the material, giving appropriate attribution to the
authors.

Permission to incorporate this software into commercial products may be
obtained by contacting USDA ARS and OREGON STATE UNIVERSITY Office for 
Commercialization and Corporate Development.
The software program and documentation are supplied "as is", without any
accompanying services from the USDA or the University. USDA ARS or the 
University do not warrant that the operation of the program will be 
uninterrupted or error-free. The end-user understands that the program was 
developed for research purposes and is advised not to rely exclusively on the 
program for any reason.

IN NO EVENT SHALL USDA ARS OR OREGON STATE UNIVERSITY BE LIABLE TO ANY PARTY 
FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING
LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, 
EVEN IF THE OREGON STATE UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF 
SUCH DAMAGE. USDA ARS OR OREGON STATE UNIVERSITY SPECIFICALLY DISCLAIMS ANY 
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AND ANY STATUTORY 
WARRANTY OF NON-INFRINGEMENT. THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS"
BASIS, AND USDA ARS AND OREGON STATE UNIVERSITY HAVE NO OBLIGATIONS TO PROVIDE
MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS. 