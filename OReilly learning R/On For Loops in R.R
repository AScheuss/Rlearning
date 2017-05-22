### On For-Loops in R

# 1. Prefer vector operations:
v1 <- 10:15
v2 <- 50:55
v3 <- v1 - v2


# 2. Generate long Vector instead of generate entries on the fly:
#prefer
bar = seq(1,200000, by=2)
bar.squared = rep(NA, 200000)

for (i in 1:length(bar) ) {
  bar.squared[i] = bar[i]^2
}
# better
bar.squared <- bar^2

#get rid of excess NAs
bar.squared = bar.squared[!is.na(bar.squared)]
summary(bar.squared)

#to

bar = seq(1, 200000, by=2)
bar.squared = NULL

for (i in 1:length(bar) ) {
  bar.squared[i] = bar[i]^2
}
summary(bar.squared)