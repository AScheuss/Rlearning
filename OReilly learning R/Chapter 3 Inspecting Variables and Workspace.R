################ Chapter 3: Inspecting Variables and your Workspace

### Classes
# Logicals
class(c(TRUE, FALSE))

# Numbers
class(1:24)
class(c(NA, NaN))
class(NA)
class(1L)
class(2+3i)
# Typing .Machine gives some info about the properties of R numbers
.Machine

# Characters
class(c("she", "sells", "sea", "shells", "on", "the", "shore"))

#Casting one Class to another:
as.integer(8)
as.character(8)
as.list(8) # etc.


## Factors
(gender <- factor(c("male", "female", "male", "male")))

levels(gender)
nlevels(gender)

# Storage Size might greatly differ
gender_asChar <- sample(c("female", "male"),1000,replace = TRUE)
gender_asFac <- as.factor(gender_asChar)

object.size(gender_asChar)
object.size(gender_asFac)

# Be Careful: Factors are Case-sensitive
(Gender <- factor(c("male", "female", "Male", "male")))
levels(Gender)

## Raw Type:
as.raw(1:17)
as.raw(c(3+2i,4,255,-256,"sea"))
charToRaw("Fish")

### There are different data types:
(trial_list <- as.list(c("the", TRUE, 255)))
(trial_array <- as.array((c("the", TRUE, 255))))
(as.matrix(matrix(c(89,32,"FALSE"), 9,5)))
(as.data.frame(matrix(c(89,32,"FALSE"), 9,5)))

### Checking and Changing Classes
## use is fuction or the class-specific variants.
is.character("jklfjlke")
is.character(4)
is.logical(FALSE)
is.numeric(1)
is.numeric(1L)
is.integer(1)
is.integer(1L)
is.double(1)
is.double(1L)

## see a complete list of all the "is-functions" in the base package:
ls(pattern = "^is", baseenv())

## change classes: two possibilities - as function or the class specific function
x <- "234.432"
x_numeric <- as(x, "numeric")
as.numeric(x)

y <-c(32,43,2,341)
as(y, "data.frame") # this will throw an error
as.data.frame(y)
## In general, the class-specific variants should always be used over standard as, if they are available.

###Examining Variables
#the automatic printing of R does not work in loops
iteration <- c(525,16,4654,987)
for (i in iteration ) i
for (i in iteration ) print(i)

##here we have different functions that allow us to inspect variables
x <- c(54,53,"jfheo", FALSE); x_array <- as.array(x); num <- runif(30); fac <- factor(sample(letters[1:5], 30, replace = TRUE)); bool <- sample(c(TRUE, FALSE, NA), 30, replace = TRUE)

print(x_array); print(num); print(fac); print(bool)
summary(x_array); summary(num); summary(fac); summary(bool)
head(x_array); head(num); head(fac); head(bool, 5) #only first lines
tail(x_array); tail(num); tail(fac); tail(bool, 5) #only last lines
str(x_array); str(num); str(fac); str(bool) #structure
View(x_array); View(num); View(fac); View(bool) #other 

#this is really handy if there is a big data structure
dfr <- data.frame(num, fac, bool)
print(dfr)
summary(dfr)
head(dfr)
str(dfr)
View(dfr)

#One can also inspect attributes (see chapter on classes)
attributes(dfr)

#A useful trick is to view the first few rows of a data frame
View(head(dfr, 50)) #view first 50 rows

#bypass the usual print function
unclass(dfr)

#View is to visualize the data. There are also functions to change the data in a simliar presentation:
new_dfr <-edit(dfr)
fix(dfr)
new_dfr
dfr


## The Workspace
#To list the names of existing variables, use the function ls
ls()
all.names = TRUE #To see hidden variables (beginning with .)

#one can also search for a pattern (RegEx):
ls(pattern = "ea")

#see the structure of the variables
ls.str()
browseEnv()

#remove variables from workspace
peach <- TRUE
ls(pattern = "peach")
rm(peach)
ls(pattern = "peach")
# rm(list = ls()) #Removes everything. Use with caution!




### Exercises:
#Exercise 3-1
#Find the class, type, mode, and storage mode of the following values: Inf, NA, NaN, ""
class(Inf); typeof(Inf); mode(Inf); storage.mode(Inf)
class(NA); typeof(NA); mode(NA); storage.mode(NA)
class(NaN); typeof(NaN); mode(NaN); storage.mode(NaN)
class(""); typeof(""); mode(""); storage.mode("")


# Exercise 3-2
# Randomly generate 1,000 pets, from the choices “dog,” “cat,” “hamster,” and “goldfish,”
# with equal probability of each being chosen. Display the first few values of the
# resultant variable, and count the number of each type of pet.

animals <- factor(sample(c("dog", "cat", "hamster", "goldfish"), 1000, replace=TRUE))
head(animals, 10)
summary(animals)

# Exercise 3-3
# Create some variables named after vegetables. List the names of all the variables in
# the user workspace that contain the letter “a.”
carrot<- FALSE
onion <- 234 
cabbage<- "this" 
pumpkin <- 455
ls(pattern = "a")