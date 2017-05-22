################ Chapter 9: Advanced Looping

# ------
### Replication
# ------

# The function "replicate" is mainly used in Monte Carlo analyses, where you 
# repeat an analysis a known number of times, and each iteration is independent of the others.
# The functions rep and replicate do almost the same.
# The difference occurs when random number generations are involved.

rep(runif(1), 5)
# [1] 0.990132 0.990132 0.990132 0.990132 0.990132

replicate(5, runif(1))
# [1] 0.22316108 0.49891668 0.78815551 0.09286732 0.49573795


time_for_commute <- function() {
  #Choose a mode of transport for the day
  mode_of_transport <- sample(
    c("car", "bus", "train", "bike"),
    size = 1,
    prob = c(0.1, 0.2, 0.3, 0.4)
  )
  #Find the time to travel, depending upon mode of transport
  time <- switch(
    mode_of_transport,
    car = rlnorm(1, log(30), 0.5),
    bus = rlnorm(1, log(40), 0.5),
    train = rnorm(1, 30, 10),
    bike = rnorm(1, 60, 5)
  )
  names(time) <- mode_of_transport
  time
}

replicate(8, time_for_commute())



# ------
### Looping over Lists
# ------

prime_factors <- list(
  two = 2,
  three = 3,
  four = c(2, 2),
  five = 5,
  six = c(2, 3),
  seven = 7,
  eight = c(2, 2, 2),
  nine = c(3, 3),
  ten = c(2, 5)
)
head(prime_factors, 5)

# We want to have a list with only the unique primes.
# We could do this with a for loop:
# unique_primes <- vector("list", length(prime_factors))
# for(i in seq_along(prime_factors))
# {
#   unique_primes[[i]] <- unique(prime_factors[[i]])
# }
# names(unique_primes) <- names(prime_factors)
# unique_primes == lapply(prime_factors, unique)

# However, to have better readability we can use the *apply-family of functions:
# NOTE: This is only for readability. There is no significant gain in performance
# lapply ("list apply"):
lapply(prime_factors, unique)
# Because unique returns different lengths of numbers, we need lapply. 

# vapply ("vector apply"):
# When the return value from the function is the same size each time, and you know what
# that size is, you can use a variant of lapply called vapply. vapply stands for “list apply
# that returns a VECTOR.”

# This will fail:
# vapply(prime_factors, unique, numeric(1))
# as well as
# vapply(prime_factors, unique, numeric(2))
vapply(prime_factors, length, numeric(1))
vapply(prime_factors, mean, numeric(1))
# Also with anonymous function
vapply(prime_factors, function(x) min(x) + 3, numeric(1))


# sapply ("simplifying list apply"):
# There is a function between lapply and vapply that does not need the specific parameter as vapply
# but that does return a vector or an array/matrix - if possible.

list.result <- sapply(prime_factors, unique)
vector.result <- sapply(prime_factors, function(parameter) {min(parameter) + 3})
array.result <- sapply(prime_factors, summary)

class(list.result)
class(vector.result)
class(array.result)

# Be careful with this functions and their return type!
sapply(list(), length) # empty list
vapply(list(), length, numeric(1)) # an empty numeric vector

# -> if your data could be empty, and you know the return value, it is safer to use vapply


# More parameters
# The rep.int function takes two arguments:
rep.int(3, times = 2)
# How can we use lapply in this situation?
# We can pass the second (or third, ...) argument to lapply:
complemented <- c(2, 3, 6, 18)
lapply(complemented, rep.int, times = 4)

# If the argument is not the first one, we have to define a helper function:
lapply(complemented, function(x) rep.int(7, times = x))

# There are two other functions in this class:
# 1. eapply: loops over all environment variables. Today this can be replaced with lapply (lapply(env, function() "do this"))
# 2. rapply: is a recursive version of lapply. Mostly it is better to flatten the data with unlist and then use lapply.



# ------
### Looping over Arrays / Matrices
# ------

# sapply and vapply tread arrays and matrices like vectors, i.e. the function will be applied
# to each entry of the array or matrix.
# However, often we want the function to apply to each row or column.

# When dealing with matrices, there is a package that gives some matlab functions.
install.packages("matlab")
library(matlab)
# NOTE: This package overrides certain functions in R in order to behave like in matlab.
# One should unload the package after it is used.
# detach("package:matlab")


magic5 <- matrix(
    1:12,
    ncol = 3,
    byrow = TRUE,
    dimnames = list(
      c("one", "two", "three", "four"),
      c("eins", "zwei", "drei")
    )
  )

# we can sum up the columns 
rowSums(magic5)
# However, if we want to have custom functions for the rows (or columns) we can use apply:
apply(magic5, 1, function(x) min(x)) # 1 stands for the dimension, here rows
apply(magic5, 2, toString)
detach("package:matlab")

# we can use apply also for data frames. However, we 
baldwins <- data.frame(
  name = c("Alec", "Daniel", "Billy", "Stephen"),
  date_of_birth = c(
    "1958-Apr-03", "1960-Oct-05", "1963-Feb-21", "1966-May-12"
  ),
  n_spouses = c(2, 3, 1, 1),
  n_children = c(1, 5, 3, 2),
  stringsAsFactors = FALSE
)

apply(baldwins, 1, toString)
apply(baldwins, 1, sum) # this will throw an error, because we cannot sum over strings

# Data frames can be thought of as nonnested lists where the elements are of the same length
# Therefore sapply behaves identically to apply on the columns:
sapply(baldwins, toString)
apply(baldwins, 2, toString)



# ------
### Multiple-Input Apply
# ------
# Sometimes we want to have access to more than one vector.
# We solve this with mapply - multiple argument list apply

# First we need a function that takes two arguments
my.message <- function(name, factors) {
  ifelse(
    length(factors) == 1,
    paste(name, "is prime"),
    paste(name, "has factors", toString(factors))
  )
}
mapply(my.message, names(prime_factors), prime_factors) # returns an array

# By default, mapply behaves like sapply. One can change this behaviour with the SIMPLIFY flag
mapply(my.message, names(prime_factors), prime_factors, SIMPLIFY = FALSE) # returns a list


## Instant Vectorization
# Sometimes we want a function to behave like a vectorized one.
gender_report <- function(gender) {
  switch(
    gender,
    male = "Dear Mister,",
    female = "Dear Miss,",
    "Hello unknown!"
  )
}

gender <- c("male","female","FEMALE/MALE","female","male")
gender_report(gender) # throws an error because switch needs a scalar
vectorized_gender_report <- Vectorize(gender_report)
vectorized_gender_report(gender)




# ------
### Split-Apply-Combine
# ------
# Our main question in this paragraph:
# How to calculate some statistic on a variable that has been split into groups?

set.seed(11)
frogger_scores <- data.frame(
  player = rep(c("Tom", "Dick", "Harry"), times = c(2, 5, 3)),
  score = round(rlnorm(10, 8), -1)
)
frogger_scores$level <- floor(log(frogger_scores$score))

# We have to do three steps:
# Split (into the groups)
# Apply (the statistic on those groups)
# Combine (the result into a single vector)

# Split:
scores_by_player <- with(
  frogger_scores,
  split(score, player)
)
# Apply:
list_of_means_by_player <- lapply(scores_by_player, mean)
# Combine:
mean_by_player <- unlist(list_of_means_by_player)

# However, to simplify these three steps, we can use the tapply function:
with(frogger_scores, tapply(score, player, mean)) # split by score and player and apply mean
with(frogger_scores, tapply(score, player, function(x) max(x))) 


# ------
### The plyr Package
# ------

# An alternative that consolidates the interface of the *-apply functions is the plyr package
# The package contains a set of functions named **ply, where the blanks (asterisks) denote the 
# form of the input and output, respectively.
# For example: llply takes a list input, applies a function to each element, and returns
# a list - the same as lapply

library(plyr)
llply(prime_factors, unique)

# laply mimicks sapply. 
# In the case of an empty input, it does the smart thing and returns an empty logical vector
laply(prime_factors, length)
sapply(prime_factors, length)
laply(list(), length)

# raply and others replace replicate
raply(5, runif(1)) #array output
rlply(5, runif(1)) #list output
rdply(5, runif(1)) #data frame output
r_ply(5, runif(1)) #discarded output


# ddply takes a data frame and returns a data frame (replaces tapply):
# All methods take a data frame, the
# name of the column(s) to split by, and the function to apply to each piece. The column
# is passed without quotes, but wrapped in a call to the . function.
ddply(
  frogger_scores,
  .(player),
  colwise(mean) #call mean on every column except player
)

# specify manipulations of specific columns by using summarize 
ddply(
  frogger_scores,
  .(player),
  summarize,
  mean_score = mean(score), #call mean on score
  max_level = max(level) #... and max on level
)





# ------
### Exercises:
# ------


# Exercise 9-1
# Loop over the list of children in the celebrity Wayans family. How many children
# does each of the first generation of Wayanses have?
wayans <- list(
  "Dwayne Kim" = list(),
  "Keenen Ivory" = list(
    "Jolie Ivory Imani",
    "Nala",
    "Keenen Ivory Jr",
    "Bella",
    "Daphne Ivory"
  ),
  Damon = list(
    "Damon Jr",
    "Michael",
    "Cara Mia",
    "Kyla"
  ),
Kim = list(),
Shawn = list(
  "Laila",
  "Illia",
  "Marlon"
),
Marlon = list(
  "Shawn Howell",
  "Arnai Zachary"
),
Nadia = list(),
Elvira = list(
  "Damien",
  "Chaunté"
),
Diedre = list(
  "Craig",
  "Gregg",
  "Summer",
  "Justin",
  "Jamel"
),
Vonnie = list()
)
# [5]
# Solution:
vapply(wayans, length, integer(1))
# or
sapply(wayans, length)



# Exercise 9-2
# state.x77 is a dataset that is supplied with R. It contains information about the
# population, income, and other factors for each US state. You can see its values by
# typing its name, just as you would with datasets that you create yourself:
#   state.x77
# 1. Inspect the dataset using the method that you learned in Chapter 3.
# 2. Find the mean and standard deviation of each column.
# [10]
str(state.x77)
summary(state.x77)
head(state.x77)
tail(state.x77)
class(state.x77)

apply(state.x77, 2, mean)
apply(state.x77, 2, sd)


# Exercise 9-3
# Recall the time_for_commute function from earlier in the chapter. Calculate the
# 75th-percentile commute time by mode of transport:
#   commute_times <- replicate(1000, time_for_commute())
# commute_data <- data.frame(
#   time = commute_times,
#   mode = names(commute_times)
# )
# [5]

commute_times <- replicate(1000, time_for_commute())
commute_data <- data.frame(
  time = commute_times,
  mode = names(commute_times)
)

tapply(commute_times, commute_data$mode, function(x) quantile(x, 0.75))
with(commute_data, tapply(time, mode, quantile, prob = 0.75))
ddply(commute_data, .(mode), summarize, time_p75 = quantile(time, 0.75))

detach("package:plyr")
