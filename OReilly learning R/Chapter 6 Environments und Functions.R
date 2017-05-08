############# Chapter 6: Environments and Functions

### Environments
## Environments are namespaces of our variables
my_env <- new.env()

# Use the assign-function in order to save variables in an environment
assign("moonday",weekdays(as.Date("1969/07/20")), my_env)

# Use the get-function in order to get back variables form an environment
get("moonday", my_env)

# Look at an environment
ls(envir = my_env)
# or just 
ls(my_env)
ls.str(my_env)

# also queries:
exists("moonday", my_env)
exists("moonday")


## Nested Environments
my_nested_environment <- new.env(parent = my_env)
# exists is looking also in the parent environment per default
exists("moonday", my_nested_environment)
# but one can prevent that
exists("moonday", my_nested_environment, inherits = FALSE)


# globalenv returns the base environment
x <- 12.3
ls.str(globalenv())
exists("x", globalenv())


# Remark: Environments are lists.
# Because of this one can convert one to the other.
my_env[["pythag"]] <- c(12, 15, 20, 21)
my_env$root <- polyroot(c(6, -5, 1))
ls.str(my_env)

( my_list <- as.list(my_env) )

# or back again
my_new_env <- list2env(my_list)
# or 
yet_another_env <- as.environment(my_list)
yet_another_env$another_thing <- "a Thing"
ls.str(my_new_env)
ls.str(yet_another_env)




### Functions
## Function is another datatype in R.
## We can define functions similar to assigning variables
## Remark: The variables of a function are saved in a seperate environment.

# Functions are defined by the function-keyword and curly braces.
my_function <- function(x,y) {
  x-y
}
# or, for functions with only one statement:
my_function <- function(x,y) x-y

my_function(9,12)

# There is no explicit return statement. 
# "In R, the last value that is calculated in the function is automatically returned."

# When calling just the name of the function, one can inspect the definition of the function.
my_function
# oder dir Funktion rt()
rt


# When defining a function, one can also pass standard arguments
my_function2 <- function(x = 5,y = 7) x-y
my_function2()
my_function2(3)
my_function2(y=3)

# If the variable is not explicitely denoted (y-3), 
# R will assume that they are given in order

# If a standard value is missing, one will receive an error.
my_function(3)


# other examples
func <- function(x=3,y) x+y 
func(3) # is not working
func(y=3); func(4, y=3); func(y=3,8); # works

# One can get the possible arguments of a function in a list or a string.
formals(func)
formalArgs(func)
args(func)

# One can get the body of a function by ...
( body_of_func <- body(func) )
# ... and one can "deparse" it into a string.
deparse(body_of_func)


## Passing Functions to and from Other Functions
# easiest example: do.call (we can give the arguments as a list.)

do.call(func, list(2,y=8))
func(2, y=8)

# integrate takes a function, a lower and an upper bound and calculates the integral.
integrate(func, lower = 0, upper = 3, y=3)
# This can also be done anonymously
integrate(function(x) x, lower = 0, upper = 3)

plot(ecdf(rt(50, 2)))

## Be carful with scope:
# Here R fails to find a variable named y in the environment belonging to h.
# Hence it looks in his parent user workspace (a.k.a. global environment), 
# where y is defined—and the product is correctly calculated.
rm(list = ls()) # this clears the workspace [can also be used for environments via 
# rm(envir = my_env, list = ls(my_env)) ]
mult <- function(x) x*y
mult(9)
y=3
mult(9)
# So global variables should be avoided.




### Excercices

# Exercise 6-1
# Create a new environment named multiples_of_pi. 
# Assign these variables into the environment:
# 1. two_pi, with the value 2 * π, using double square brackets
# 2. three_pi, with the value 3 * π, using the dollar sign operator
# 3. four_pi, with the value 4 * π, using the assign function

multiples_of_pi <- new.env()
multiples_of_pi[["two_pi"]] <- 2*pi
multiples_of_pi$three_pi <- 3*pi
assign("four_pi", 4*pi, envir = multiples_of_pi)

# List the contents of the environment, along with their values. [10]
ls.str(envir = multiples_of_pi)



# Exercise 6-2
# Write a function that accepts a vector of integers 
# (for simplicity, you don’t have to worry about input checking) 
# and returns a logical vector that is TRUE whenever the input is even, 
# FALSE whenever the input is odd, and NA whenever the input is non‐finite 
# (nonfinite means anything that will make is.finite return FALSE: Inf, -Inf, NA, and NaN). 
# Check that the function works with positive, negative, zero, and non‐ finite inputs. [10]

my_function <- function(x) {
  x%%2 == 0
}

my_function(2)
my_function(3)
my_function(12314274897)
my_function(NA)
my_function(Inf)
my_function(-Inf)
my_function(NaN)




# Exercise 6-3
# Write a function that accepts a function as an input and returns a list with two elements: 
# an element named args that contains a pairlist of the input’s formal arguments, and an 
# element named body that contains the input’s body. Test it by calling the function with 
# a variety of inputs. [10]


function_function <- function(func) {
  list <- list()
  list[["args"]] <- formalArgs(func)
  list[["body"]] <- body(func)
  return(list)
}
function_function(my_function)
function_function(mean)
function_function(integrate)