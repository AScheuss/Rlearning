##################### Notizen zu Learning R (O'Reilly)

######### Kapitel 1: Installatation and Help


###Help and search

# ? opens the help page for the function median
?median 
?"+"
?"if"
help(median) #Does the same
help("+")

# ?? Searches for topics that contain "median"
??median 
??"if"
help.search("median") #Does the same
help.search("if")

#?? bzw. help.search sucht nur auf diesem System. Um in allen packages zu suchen benutze
RSiteSearch("Sweave")
# Multiword terms need to be wrapped in braces
RSiteSearch("{Bayesian regression}")

# apropos finds variables (including functions) that matches its input
apropos("vector") 
apropos("median")
apropos("norm")

#works also with regular expressions (http://www.regular-expressions.info/quickstart.html)
apropos("z$")
apropos("[4-9]")
apropos("[8-9]")



### Examples, Demos and Vignettes (documentations of packages)
example(mean)
example(plot)

demo()
demo(Japanese)

#vignettes are documentations of packages
browseVignettes() #Browse all the vignettes on the current system

vignette("Comparisons", package="Matrix")
vignette(package = "utils")
browseVignettes()

# There are also some sites:
# http://rseek.org/
# http://www.r-project.org/mail.html
# http://www.r-bloggers.com/


###Installing extra related packages

install.packages("installr") # download and install the package named installr
library(installr) #load the installr package
library(utils)





### Exercises:
#1.2: Calculate the standard deviation of the numbers from 0 to 100 (There is the function sd)
sd(0:100)
