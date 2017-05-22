################ Kapitel 7: Strings and Factors

### Strings
# Strings are basically character vectors. 
# That means that most string manipulation functions operate on vectors of strings,


c("'What a nice weather', Fred said.", 'This grumpy old " ', "This and '")
# -> use ' in strings, because " will be escaped.

# combine strings with the paste-function:
paste("cool", "stuff")
paste("cool", c("stuff", "people"))
# add separators
paste("very", "cool", "stuff", sep = "-")
paste("cool", c("stuff", "people"), sep = ";")
# if one does not need a separator use paste0 
paste0("st", "uff")

# combine all the string to a single one with collapse argument
paste("cool", c("stuff", "people"), sep = ";", collapse = ";")
paste("cool", c("stuff", "people"), sep = ";", collapse = ";")


# With "toString" we give out strings of vectors
toString(1:15)
# one can also limit the number of characters of the output
toString(1:15, width = 20)

# with noquote one can get rid off the quotes
c("stuff", "people")
noquote(c("stuff", "people"))

# (on a low-level-basis R uses the cat-function, which is similar to paste)
cat(c("red", "yellow"), "lorry", sep = ",") # similar but not the same as this shows...


## Formating numbers
# there is the function formatC that uses C-style formatting configurations 
# and returns a character vector
( some_numbers <- sqrt(1:4 * 7) )
( some_numbers <- exp(1:4) )
formatC(some_numbers)
formatC(some_numbers, digits = 3, width = 7)
formatC(some_numbers, digits = 3, format = "e") # scientific formatting

# sprintf works like in C or other languages
# %s denotes another string, 
# %f and %e denote a floating-point number in fixed or scientific format, respectively
# %d represents an integer
sprintf("%s %d = %f", "Euler's constant to the power", 1:4, some_numbers)
sprintf("%s = %d", "cool", some_numbers) # throws an error
sprintf("To six decimal places, e ^ %d = %.6f", 1:4, some_numbers)
sprintf("And in scientific notation %.3e", some_numbers)

# also there is the format-function, that uses a different syntax
format(some_numbers, digits = 5, scientific = TRUE)

# for very big or very small numbers one uses best the prettyNum-function
prettyNum(
  c(1e10, 1e-20),
  big.mark = ",",
  small.mark = " ",
  preserve.width = "individual",
  scientific = FALSE
)


## Special Characters
# tabs
cat("this\tthat", fill = TRUE)
# newline
cat("this\nthat", fill = TRUE)
# backslash etc. must be escaped
cat("this\\that", fill = TRUE)


## change case
toupper("such a nice thing")
tolower("SUCH A NICE THING")


## substrings
quote <- "We must develop and maintain the capacity to forgive. 
He who is devoid of the power to forgive is devoid of the power to love. 
There is some good in the worst of us and some evil in the best of us. 
When we discover this, we are less prone to hate our enemies." # Martin Luther King Jr.

substring(quote,0, 12)
