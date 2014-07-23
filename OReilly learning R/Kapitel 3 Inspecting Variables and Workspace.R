################ Kapitel 3: Inspecting Variables and your Workspace

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
