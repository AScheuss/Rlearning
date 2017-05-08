##### Chapter 4 Vectors

## We know the Colon operator:
4.6:6.8

### Empty vectors:
v1 <- vector("numeric", 3)
vList <- vector("list", 4)
## Also there are convenience methods
complex(5)
logical(8)
## be careful: list(5) is something different

### The seq-function:
##(most general, not used often)
seq.int(3,12) # or seq(3,12) --- = 3:12
seq.int(3,12,4)
seq.int(3.2,3,-0.04)

seq_len(6) # or seq(6) --- = 1:6, i.e. from 1 to the input number
## however, note the difference:
seq_len(0)
1:0

seq_along(c(3,4,5)) #or just seq --- go along the length of the input
pp <- c("Peter", "Piper", "picked", "a", "peck", "of", "pickled", "peppers")
for(i in seq_along(pp)) {print(pp[i])}

### Names
## each element of a vector can be given a name
c(banana = 4, things = 6,"cool stuff" = 7,84)
## or asign it afterwards with the names-function
v1 <- c(4,6,7,84,294)
v1
names(v1)  <- c("banana", "things", "cool stuff","")
v1
## or retrieve the name
names(v1)
names(1:5)

### Indexing Vectors
# with positive or negative numbers and vectors, logicals and - for numbered vectors - their name
v1 <- seq(56,70,2)
v1[3]
v1[c(4,6,99)] # get the indices indicated by the vector  
v1[c(-4,-5)] # remove the indices indicated by the vector
v1[c(TRUE, FALSE)] # the logical will be duplicated and concated
v1[c(TRUE, FALSE, FALSE, TRUE, TRuE, TRUE, TRUE, TRUE, TRUE)]
names(v1) <- c("cool", "nice", "hip", "proper")
v1["proper"]

# Don't mix positive and negative numbers - you cannot do that!
v1[c(-2,4)]
# Missing value in the index will result in missing value for the variable
v1[c(4,NA)]
# Noninteger indices are silently rounded toward zero (i.e. the Gaussian bracket)
v1[4.6] == v1[4]

## The which-function returns the locations where a logical vector is TRUE - useful for switching indices
new.indices <- which(v1 >60) 
# more efficient convenience methods:
which.min(v1)
which.max(v1)
v1[which.max(v1)] == max(v1)

### Vector Recycling and Repetition

# If we try to add a single number to a vector, then that number is added to each element
1:5 + 1
1 + 1:5
# When adding two vectors the smaller one is concated by itself to fit the length
1:5 + 1:15
1:15 + 1:5
# With non-divisor lengths, there is a warning but the same behaviour
1:6 - 1:15

## Therefore it is advisable to create equal lenght vectors before doing calculations
rep(1:4, 3) # replicate several times
rep(1:4, each=4) # order 
rep(1:4, times=c(4,2,3,5)) # control how many times a number is taken
rep(1:4, length=7) # replicate to a certain length
rep(1:4, length.out=7) # replicate to a certain length

#analogously to seq, there is rep.int and rep_len
rep.int(4:5, 5) #suppposedly it is faster and more efficient for numerics
rep_len(c(83,32,1), 13) # without warning

### Matrices and Arrays
# Arrays hold multidimensional rectangular data. “Rectangular” means that each row is 
# the same length, and likewise for each column and other dimensions. Matrices are a 
# special case of two-dimensional arrays.

## Create an Array

# Several dimensions: 
# The entries are filled columnwise
(three_d_array <- array(
  1:24,
  dim = c(4, 3, 2),
  dimnames = list(
    c("one", "two", "three", "four"),
    c("eins", "zwei", "drei"),
    c("un", "deux")
  )
))

# [if the size of the entries of the input (below 1:25) is less than the total number of array entries, the input will be repeated]
(four_d_array <- array(
  1:25,
  dim = c(4, 3, 2, 2),
  dimnames = list(
    c("one", "two", "three", "four"),
    c("eins", "zwei", "drei"),
    c("un", "deux"),
    c("uno", "dos")
  )
))
class(four_d_array)


# Matrices are just two dimensional arrays:
(two_d_array <- array(
  1:12,
  dim = c(4, 3),
  dimnames = list(
    c("one", "two", "three", "four"),
    c("eins", "zwei", "drei")
  )
))
class(two_d_array)

# There is also another method to specifically construct matrices:
(a_matrix <- matrix(
  1:12,
  nrow = 4, #ncol = 3 works the same
  dimnames = list(
    c("one", "two", "three", "four"),
    c("eins", "zwei", "drei")
  )
))
identical(two_d_array, a_matrix)

# The values that you passed in fill the matrix column-wise. Use the argument byrow = TRUE to do otherwise:
matrix(
  1:12,
  ncol = 3
  byrow = TRUE,
  dimnames = list(
    c("one", "two", "three", "four"),
    c("eins", "zwei", "drei")
)


## Dimension, ncol and nrow
dim(four_d_array)
dim(a_matrix)

# ncol returns the amount of the first array, ncol the one of the second array
ncol(four_d_array)
nrow(four_d_array)
ncol(a_matrix)
nrow(a_matrix)

# NROW and NCOL are similar to ncol and nrow but will also work vor vectors (ncol/nrow returning NULL)
a_vector <- 1:8
NROW(a_vector)
NCOL(a_vector)
nrow(a_vector)
ncol(a_vector)
# dim does not work for vectors
dim(a_vector)

# Be careful! length returns the number of entries (just as for the vector)
length(a_matrix)
length(three_d_array)
length(four_d_array)

## Row Column and Dimension names
# As we have seen in the example, we can assign names to the dimensions
# We can do this also after the initialization

rownames(a_matrix) <- c("EINS", "ZWEI", "DREI", "VIER")
colnames(a_matrix) <- c("ONE", "TWO", "THREE")
a_matrix

# dimnames is similar but returns a list and therefore we change our 
dimnames(a_matrix) <- list(c("one", "two", "three", "four"), c("eins", "zwei", "drei")) 


## Indexing an Array 
# works the same as with vectors except that one needs to seperate the different dimensions with commas
four_d_array[c(TRUE, FALSE, TRUE, FALSE), , c(TRUE, FALSE), "uno"]
four_d_array[c(TRUE, FALSE, TRUE, FALSE), c(2,3), c(TRUE, FALSE), -1]
a_matrix[c("three", "one"), c("zwei", "drei")]

## Combining Matrices
# The c function converts matrices to vectors before concatenating them:
  (another_matrix <- matrix(
    seq.int(102, 124, 2),
    nrow = 4,
    dimnames = list(
      c("five", "six", "seven", "eight"),
      c("vier", "fünf", "sechs")
    )
  ))
c(a_matrix, another_matrix)

# cbind and rbind concatinate the matrices in a more natural way
cbind(a_matrix, another_matrix)
rbind(a_matrix, another_matrix)
rbind(cbind(a_matrix, another_matrix), cbind(another_matrix, a_matrix))


## Array Arithmetic
# +, -, *, /. ^ work element-wise
a_matrix + another_matrix -2*another_matrix
a_matrix * another_matrix / a_matrix
another_matrix / 2
(a_matrix ^(-1))

a_matrix

# Doing operations on non-equal dimensional arrays will repeat the operation on the elements 
# and an warning will be displayed if they are not divisible (similar to adding vectors - "vector recycling rules")
a_vector <- 1:8
four_d_array * a_vector
length(four_d_array) / length(a_vector)
a_vector <- 1:5
four_d_array * a_vector
length(four_d_array) / length(a_vector)


## Matrix operations
# t is transponation
t(a_matrix)
identical(a_matrix, t(t(a_matrix)))
# %*% is the classical matrix multiplication
a_matrix %*% t(another_matrix)
a_vector <- 1:nrow(a_matrix)
a_vector %*% a_matrix

a_vector <- 1:ncol(a_matrix)
a_matrix %*% a_vector

# %o% or outer() is outer or tensor product of matrices
a_vector %o% a_vector
a_vector <- 1:4
(even_another_matrix <- x %o% x)
class(even_another_matrix)

identical(even_another_matrix, outer(x,x))

# inverting a matrix has to be done with the solve function [or qr.sovlve(m) or chol2inv(chol(m))]
yet_another_matrix <- cbind(1:3, 6:4, c(8,7,9))
inverted_matrix <- solve(yet_another_matrix)
yet_another_matrix %*% inverted_matrix

# the crossproduct
crossprod(a_vector, 1:length(a_vector))
tcrossprod(a_vector, 1:length(a_vector))

# the eigen fuction returns vectors and values
eigen(yet_another_matrix)


### Exercises:
##Exercise 4-1
# The nth triangular number is given by n * (n + 1) / 2. Create a sequence of
# the first 20 triangular numbers. R has a built-in constant, letters, that
# contains the lowercase letters of the Roman alphabet. Name the elements of the
# vector that you just created with the first 20 letters of the alphabet. Select
# the triangular numbers where the name is a vowel.
n <- 1:20
triangular <- n*(n+1)/2
names(triangular) <- letters[seq_along(n)] # we use seq_along as it is safer.However, we could also use n
triangular[c("a", "e", "i", "o", "u")]

## Exercise 4-2 
# The diag function has several uses, one of which is to take a vector as its
# input and create a square matrix with that vector on the diagonal. Create a
# 21-by-21 matrix with the sequence 10 to 0 to 10 (i.e., 10, … , 1, 0, 1, …,
# 10).
ex4.2_matrix <- diag(abs(-10:10))

## Exercise 4-3
# By passing two extra arguments to diag, you can specify the dimensions of the
# output. Create a 20-by-21 matrix with ones on the main diagonal. Now add a row
# of zeros above this to create a 21-by-21 square matrix, where the ones are offset a
# row below the main diagonal.
matrix <- diag(rep(1, 20),nrow = 20,ncol = 21)
matrix <- rbind(0, matrix)
dim(matrix)

# Create another matrix with the ones offset one up from the diagonal.
other_matrix <- diag(rep(1, 20),nrow = 21,ncol = 20)
other_matrix <- cbind(0, other_matrix)

# Add these two matrices together, then add the answer from Exercise 4-2. The resultant
# matrix is called a Wilkinson matrix.
wilkinson.matrix <- matrix + other_matrix + ex4.2_matrix

# The eigen function calculates eigenvalues and eigenvectors of a matrix. Calculate
# the eigenvalues for your Wilkinson matrix. What do you notice about them?

eigen(wilkinson.matrix)$values

# Two eigenvalues are often quite near, the more we get to 0 the more they differ.
# The eigenvectors are "symmetric"