##### Vectors

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
ar1 <- array(1:4, 1:3)
ar1
View(ar1)
