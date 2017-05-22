################ Chapter 8: Flow Control and Loops

# ------
### If and Else
# ------
x <- runif(1, min = 0, max = 1)
if(x <= 0.5) {
  message("Coin is head.")
} else {
  message("Coin is tail.")
}

# else if
x <- runif(1, min = 0, max = 1)
if(x <= 0.5) {
  message("One half")
} else if(x <= 0.75) {
  message("Three quarter")
} else {
  message("All")
}

# ------
## Vectorized if
# ------
# if is not vectorized
if(c(FALSE, TRUE)) message("strange")

# There is the function "ifelse"
ifelse(rep.int(c(FALSE, TRUE), 3), -1:-3, 1:6)

# ------
## Multiple Selection - the switch-command
# ------

switch.variable <- "three"

switch(
  switch.variable,
  one = 3,
  two = 9,
  three = {
    ifelse(round(runif(1,0,1)) == 0, 4, 10)
  }
  )

# We might also want to define a default
switch.variable <- "four"

switch(
  switch.variable,
  one = 3,
  two = 9
)

switch(
  switch.variable,
  one = 3,
  two = 9,
  "standard" # this will be given if neither "one" nor "two" is represented by the switch.variable
)


# This works also for numbers as switch.variables
# (however, then no default is possible)

switch(
  2,
  "one",
  "two",
  "three"
)

# ------
### Loops
# ------
# There is the possibility to use loops in R.
# HOWEVER, almost always a "vectorized" solution will be better performance-wise.

# ------
## repeat Loops
# ------

# The repeat loop is repeating the loop until it is stopped by a break (or an abort)

repeat {
  message("Hold on")
  
  if (0.9 < runif(1,0,1)) { break }
}

# Instead of breaking the loops we can also step to the next iteration with "next"

repeat {
  message("Hold on")
  
  x <- runif(1,0,1)
  if (0.6 < x && 0.9 > x) { next }
  message("Hold on longer!")
  
  if (0.9 < x) { break }
}

# ------
## while Loops
# ------
x <- -1
while(x < 0.9) { # run until x >= 0.9
  x <- runif(1, min = 0, max = 1)
  message("Not there yet")
}

# Note one could fiddle with the repeat loop to get a while loop.
# Usually (according to "Learning R") a repeat loop is used 
# if one wants to execute it at least once

# ------
## for Loops
# ------
for (i in 1:5) {
  message("Counting: ", i^2)
}

# one can also iterate over vectors and lists 
for (month in month.name) {
  message("The month of ", month)
}


l <- list(
  pi,
  LETTERS[1:5],
  list(TRUE, FALSE),
  "last item"
  )
for (item in l) {
  print(item)
}








# ------
### Exercises:
# ------

# ------
# Exercise 8-1
# ------
# In the game of craps, the player (the “shooter”) throws two six-sided dice. If the
# total is 2, 3, or 12, then the shooter loses. If the total is 7 or 11, she wins. If the total
# is any other score, then that score becomes the new target, known as the “point.”
# Use this utility function to generate a craps score:
#   two_d6 <- function(n)
#   {
#     random_numbers <- matrix(
#       sample(6, 2 * n, replace = TRUE),
#       nrow = 2
#     )
#     colSums(random_numbers)
#   }
# Write code that generates a craps score and assigns the following values to the
# variables game_status and point:

two_d6 <- function(n)
{
  random_numbers <- matrix(
    sample(6, 2 * n, replace = TRUE),
    nrow = 2
  )
  colSums(random_numbers)
}

game_of_craps <- function() {
  result <- two_d6(1)
  if (result == 2 || result == 3 || result == 12) {
    game_status <- FALSE
    point <- NA
  } else if (result == 7 || result == 11) {
    game_status <- TRUE
    point <- NA
  } else {
    game_status <- NA
    point <- result
  }
  c(game_status, point)
}
game_of_craps()

# ------
# Exercise 8-2
# ------
# If the shooter doesn’t immediately win or lose, then he must keep rolling the dice
# until he scores the point value and wins, or scores a 7 and loses. Write code that
# checks to see if the game status is NA, and if so, repeatedly generates a craps score
# until either the point value is scored (set game_status to TRUE) or a 7 is scored (set
# game_status to FALSE). [15]

game_of_craps2 <- function() {
  result <- two_d6(1)
  if (result == 2 || result == 3 || result == 12) {
    game_status <- FALSE
    point <- NA
  } else if (result == 7 || result == 11) {
    game_status <- TRUE
    point <- NA
  } else {
    game_status <- NA
    point <- result
  }
  c(game_status, point)
  
  if(is.na(game_status)) {
    repeat({
      result <- two_d6(1)
      if(result == 7) {
        game_status <- FALSE
        break
      } else if(result == point) {
          game_status <- TRUE
          break
      } else {
        point <- result
      }
    })
  }
  message(paste("You have won:", game_status))
  message(result)
}
game_of_craps2()

# ------
# Exercise 8-3
# ------
# This is the text for the famous “sea shells” tongue twister:
#   sea_shells <- c(
#     "She", "sells", "sea", "shells", "by", "the", "seashore",
#     "The", "shells", "she", "sells", "are", "surely", "seashells",
#     "So", "if", "she", "sells", "shells", "on", "the", "seashore",
#     "I'm", "sure", "she", "sells", "seashore", "shells"
#   )
# Use the nchar function to calculate the number of letters in each word. Now loop
# over possible word lengths, displaying a message about which words have that
# length. For example, at length six, you should state that the words “shells” and
# “surely” have six letters. [10]

sea_shells <- c(
  "She", "sells", "sea", "shells", "by", "the", "seashore",
  "The", "shells", "she", "sells", "are", "surely", "seashells",
  "So", "if", "she", "sells", "shells", "on", "the", "seashore",
  "I'm", "sure", "she", "sells", "seashore", "shells"
)

word.list <- list()

for (i in 1:(max(nchar(sea_shells)) -1)) {
  word.list[[i]] <- list()
  for (word in sea_shells){
    if (nchar(word, keepNA=TRUE) == i) {
      word.list[[i]] <- append(word.list[[i]], word)
    }
  }
  if (length(word.list[[i]]) > 0) {
    message("The following words have ", i, " letters")
    message(unique(unlist(word.list[[i]])), " ")  
  } else {
    message("No words found that have ", i, " letters")
  }
}
rm(i)
print(unique(unlist(word.list)))
