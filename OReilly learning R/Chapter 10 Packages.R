################ Chapter 10: Packages

# ------
### Loading Packages
# ------

library(lattice)

dotplot(
  variety ~ yield | site,
  data = barley,
  groups = year
)

detach("package:lattice")

# load in loop
pkgs <- c("lattice", "utils", "rpart")
for (pkg in pkgs) {
  library(pkg, character.only = TRUE)
}

# And also detach in loop
pkg <- c("package:lattice","package:utils","package:rpart") # This time with lapply and not a for loop
lapply(pkg, detach, character.only = TRUE, unload = TRUE) # 


# library throws an error if the package could not get loaded
# to better control this event there is the require method.
# It returns TRUE or FALSE in the appropriate case.
if (!require(apackagethatmightnotbeinstalled)) {
  warning("The package 'apackagethatmightnotbeinstalled' is not available.")
  #perhaps try to download it
  #...
}

## The search() method returns all the packages that are loaded:
search()

# This list also shows the order of places that R will look to try to find a variable.
# I.e. it will start in the ".GlobalEnv" environement and go on until "Autoloads" and finally the base package.


# The method "installed.packages()" returns a data.frame with all the information of the packages
# that are known to R.
View(installed.packages())

# To see the paths of the libraries use 
.libPaths()

# or more specific
# for the home library>
Library
# or
R.home("library")

# We can also get the home folder and then look in "Library/R/x.y/library" (Mac OS X) or R/win-library/x.y (Windows)
# where x.y.z is the R version (for example 2.15.0)
Sys.getenv("HOME")
# or
path.expand("~")



# ------
### Installing Packages
# ------

# With a new install one can already access CRAN
# However one might want to set the repository with
setRepositories()


# we can also get a list of all available packages
head(available.packages())
# View(available.packages()) # be careful there are a lot of packages!

# For installing one can use the gui help in R GUI or RStudio or the install.packages() method
install.packages(
  c("xts", "zoo"),
  repos = "http://www.stats.bris.ac.uk/R/" # specify the repo to download from
)

# With the lib parameter one can also specify the library (i.e. the directory) where the files 
# should be downloaded to:

# install.packages(
#   c("xts", "zoo"),
#   lib = "some/other/folder/to/install/to",
#   repos = "http://www.stats.bris.ac.uk/R/"
# )


# Or one could download the source code and build it locally

# install.packages(
#   "path/to/downloaded/file/xts_0.8-8.tar.gz",
#   repos = NULL, #NULL repo means "package already downloaded"
#   type = "source" #this means "build the package now"
# )


# Or install directly from GitHub
# (The "devtools" package needs to be installed for this)
install.packages("devtools")


# The install_github function accepts the name of the GitHub repository that contains
# the package (usually the same as the name of the package itself) and the name of the
# user that maintains that repository. For example, to get the development version of the
# reporting package knitr, type:
library(devtools)
install_github("knitr", "yihui")


# ------
### Maintain Packages
# ------

# updating
update.packages() # by default the function asks beforehand. Surpress this behaviour with "ask = FALSE"


# deleting
remove.packages("zoo")








# ------
### Exercises:
# ------


# Exercise 10-1
# Using R GUI, install the Hmisc package. [10]
# Skipped because using RStudio and it is pretty simple...

# Exercise 10-2
# Using the install.packages function, install the lubridate package. [10]
install.packages("lubridate")


# Exercise 10-3
# Count the number of packages that are installed on your machine in each library.
# [5]
pkgs <- installed.packages()
table(pkgs[, "LibPath"])
#or get the version
pkgs[, "Version"]
