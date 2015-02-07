#### Kapitel 5 Lists and Data Frames
## Lists and data frames let us combine different types

### Lists (Vectors with different types)
# Creating lists
(a_list <- list(9.4,'total', c('cool','wicked','nice'),c(3,45,34),asin,month.abb))

# Naming works as with vectors
names(a_list) <- c('a number', 'a string', 'nice strings', 'some integers', 'arcsin', 'months')
a_list
(some_other_list <- list(
  "a string" = 'something similar',
  "an integer" = 9,
  "some numbers" = c(4,32.3,5)))

(list_of_lists <- list(list(c(4,3),'na so was'), 9, list(5,4,'cool')))


## Atomic and Recursive variables
# Because we can construct list of lists we say that list is a recursive variable
# The contrary expression is 'atomic'
# Every variable is either atomic or recursive, never both
# One can test this with the 'is.recursive' or 'is.atomic' functions
is.recursive(some_other_list)
is.atomic(some_other_list)
is.recursive(c(3,6,5))
is.atomic(c(3,6,5))


# Also length, dim, ncol/NCOL and nrow/NROW the same as with vectors (in particular dim does not work...)
length(a_list)
length(list_of_lists)

dim(a_list)
ncol(a_list)
NCOL(a_list)
nrow(a_list)
NROW(a_list)

# Arithmetic on lists does not work (obviously as the elements are of different types...)
# One has to access the elements of the list itself

a_list[[1]] + some_other_list[[2]]

# Perform stuff on every element of a list needs looping...

# Indexing works like with vectors

some_other_list[c(TRUE, FALSE, TRUE)]
a_list[1:3]
list_of_lists[c(-1,-3)]
a_list['a string']

# Access content of the list with double [[]]
a_list[['a string']]

# is.list works in the obviou way
is.list(a_list[3])
is.list(a_list[[3]])

# Use $-signs to access named elements of a list (similar to vectors)
a_list$'nice strings'
names(list_of_lists) <- c('one','two','three')
is.list(list_of_lists$three)
is.list(list_of_lists$two)

# Access nested elements
list_of_lists[['one']][1]
list_of_lists[['one']][[1]]
list_of_lists[[c('one',1)]] #however this looks nasty...

# Be careful when accessing a nonexistent element:
list_of_lists$four
list_of_lists[4]
list_of_lists[['four']]
list_of_lists[[4]] #the behaviour of R in this case it not nice...

## Converting Between Vectors and Lists
(a_vector <- c(4,3,2,4,5,9))
(a_list_from_a_vector <- as.list(a_vector))
is.list(a_list_from_a_vector)

# Converting from a list to a vector works with as.numeric, as.character etc.
# However, only if every element is of that type
as.numeric(list_of_lists)
as.numeric(a_list_from_a_vector)

# lists are very useful for storing data of the same type, but with a nonrectangular shape
# in this case as.-functions don't work
# use 'unlist'

(prime_factors <- list(
  'two' = 2,
  'three' = 3,
  'four' = c(2,2),
  'five' = 5,
  'six' = c(2,3),
  'seven' = 7,
  'eight' = c(2,2,2),
  'nine' = c(3,3)))
as.numeric(prime_factors)
unlist(prime_factors)

# Concatenating lists works as with vectors with c-function
c(list('one'=1, 'two'=2),list(2))
# One can also add other types or vectors (implicitely the as.list-function is used)
c(list(1,2), c(3,4,5),'stir it up', some_other_list$'some numbers')

# One can also use cbind and rbind but this result in some strange objects and therefore this should be used carefully

### NULL