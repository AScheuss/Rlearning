############# Chapter 2: R as a Scientific Calculator

### Vectorization

# colon and c - your best friend when generating vectors:
1:25
c(1,2,2,3,5)

1:25 + 26:50
sin(c(pi,2*pi,3*pi,4*pi))

# Be aware:
sum(1:15)
sum(5,6,3,8)
#but not
median(4,3,2,1)

1:5 * 5
1:5 * 1:5

1:5 %% 5
1:5 %% 5:1

# Division:
#Floating point division:
25/5
25/3 

# Integer division:
25 %/% 5
25 %/% 3

# Modulo:
25 %% 5
25 %% 3

choose(8,0:8)
exp(1i*pi)+1

factorial(7) + factorial(1) -71^2

1:3 > 2
1:3 >= 2


## Comparing integers and non-integers: Usually DON'T USE == but all.equal()
25/5 == 5
25/5 == 5.0

exp(1i*pi)+1 == 0i
exp(1i*pi)+1 == 0
all.equal(exp(1i*pi)+1,0i)
all.equal(sqrt(2),1.41)

# If one requires a TRUE/FALSE-statement 
isTRUE(all.equal(sqrt(2),1.41))

#compare strings
strings <- c("klo", "ko","fo","58", "klos", "KLO")
strings == "klo"

#be careful to use < or >, as the sorting of the alphabet depends on the locale:
strings >= "klo"
"m">"l"
"a">"l"
##help pages: 
?Arithmetic
?Trig
?Special
?Comparison

### Assigning Variables
x<- 1:5
(y = 6:10)
x +<- 1:5

# Do a global assignment using <<-
h <<- 25.5

# Assignments using the assign function:
#local
assign("my_local_variable",exp(1))
#global
assign("my_global_variable",25+98*8,globalenv())

# Assign a value and print it in one line
# type the value
b<- 25; b
(b <-25)


### Special numbers and logical vectors

Inf; -Inf; NA
c(52,1/0,-5*Inf,0*Inf)
sqrt(sin(Inf))
n <-c(58,NA +5,Inf *89, NA +Inf, Inf/Inf)
is.nan(n)
is.na(n)
is.infinite(n)
is.finite(n)

## Logical operators and vectors:
1:5 <3
!(1:5 <3)
1:5 <3 & 26:30 > 27
1:5 <3 && 26:30 > 27 #FOOTNOTE As the help page says, this makes the longer form "appropriate for programming control-flow and [is] typically preferred in if clauses." So you want to use the long forms only when you are certain the vectors are length one. You should be absolutely certain your vectors are only length 1, such as in cases where they are functions that return only length 1 booleans. You want to use the short  forms if the vectors are length possibly >1. So if you're not absolutely sure, you should either check first, or use the short form and then use all and any to reduce it to length one for use in control flow statements, like if.
1:5 <3 | 26:30 > 27

"some_true" <- c(FALSE, TRUE, FALSE)
"all_true" <- c(TRUE, TRUE, TRUE)
"no_true" <-c(FALSE, FALSE, FALSE)
any(some_true)
any(all_true)
any(no_true)
all(some_true)
all(all_true)
all(no_true)


# EXERCISES
#2-1 a: Calculate the inverse tan (i.e. arctan) of the reciprocal of 1:1000
atan2(1,1:1000)
atan(1 / 1:1000)

#2-1 b: Assign the variables and do the inverse calculation
x <- 1:1000
y <- atan2(1,x)
z <- 1/tan(y)

# 2-2: Compare the results from 2-1
x == y
identical(x,z)
all.equal(z,x)

#try tolerance, what happens if tolerance is =0?
all.equal(z,x,.00001)
all.equal(z,x,0)

# 2-3: Use TRUE, FALSE and NA
true_and_missing = c(TRUE, NA)
false_and_missing = c(FALSE, NA)
mixed = c(FALSE, TRUE, NA)

any(true_and_missing)
any(false_and_missing)
any(mixed)

all(true_and_missing)
all(false_and_missing)
all(mixed)