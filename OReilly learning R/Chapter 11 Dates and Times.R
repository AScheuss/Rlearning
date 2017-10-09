################ Chapter 11: Dates and Times

# ------
### Classes for Dates and Times
# ------

## POSIX:
# There are two standard classes for date-time: POSIXct and POSIXlt.
# ct is short for calendar times and lt (probably) for list time

(now_ct <- Sys.time())
class(now_ct)
unclass(now_ct) # just a number

(now_lt <- as.POSIXlt(now_ct))
class(now_lt)
unclass(now_lt) # a list of information
#therefore we can access the fields in the list:
now_lt$sec
now_lt$year
now_lt[["year"]]
now_lt$isdst # Daylight Saving Time flag. Positive if in force, zero if not, negative if unknown.

## Date
# There is a third date class in base R: date
# It stores the date as numbers of days since the start of 1970 (Hence be careful when working with older data)
(now_date <- as.Date(now_ct))
class(now_date)
unclass(now_date)

# If you want to add days use date:
now_date + 365
# For POSIX it adds seconds
now_ct + 5 
now_lt + 3


# There are also other classes



# ------
### Conversion to and from Strings
# ------

## Parsing Dates:
# there is the strptime function ("string parse time")
strptime("2016-10-10", "%Y-%m-%d")
# The time zone - if not set explicitely - is taken form the operating system
# use "" to use the time zone in the current locale, or state the time zone explicitely, usually "UTC"
strptime("2016-10-10", "%Y-%m-%d", tz = "UTC"); strptime("2016-10-10", "%Y-%m-%d", tz = "")
# %H - hour
# %M - minute
# %S - second
# 
# %d - day
# %m - month
# %Y - year
(first_moon_landing_lt <- strptime("20:17:40 20/07/1969", "%H:%M:%S %d/%m/%Y", tz = "UTC"))
(eulers_birthday_lt <- strptime("15.06.1707", "%d.%m.%Y", tz = "CET"))

# If the format does not match a NA is produced
(eulers_birthday_lt <- strptime("15.06.1707", "%d/%m/%Y", tz = "CET"))

# Note: as.POSIXlt("2017-11-01") wraps it - however be careful about the standard format and time zones
unclass(as.POSIXct("2017-11-01"))
(as.POSIXct("2017-12-19"))


## Formatting Dates:
# We have the function strftime for formatting dates

strftime(first_moon_landing_lt, "Die erste Mondlandung war um %H:%M Uhr am %A %d %B, %Y.")
strftime(first_moon_landing_lt, "The first moonlanding was at %I:%M%p on %A %d %B, %Y.") # use locale specifics like %I see also https://stat.ethz.ch/R-manual/R-devel/library/base/html/strptime.html

# works with ct and lt
strftime(as.POSIXct(first_moon_landing_lt), "Die erste Mondlandung war um %H:%M Uhr am %A %d %B, %Y.")
# format also works in higher versions of R
format(first_moon_landing_lt, "Die erste Mondlandung war um %H:%M Uhr am %A %d %B, %Y.")


## Time Zones:
# Time zones are complicated (https://www.xkcd.com/1883/ , https://www.youtube.com/watch?v=-5wpm-gesOY)
# In R time zones are based on the locale> Sys.getlocale("LC_TIME") (if you do not specify it with "tz")
# To avoid problems try to always use UTC (Universal Coordinated Time)
# An easy way to specify time zones is to use the Olson form, which is “Continent/City”:
strftime(now_ct, tz = "America/Los_Angeles")
strftime(now_ct, tz = "Europe/Paris")
strftime(now_ct, tz = "Europe/Zurich")
strftime(now_ct, tz = "Europe/Berlin")
strftime(now_ct, tz = "Africa/Brazzaville")
strftime(now_ct, tz = "Asia/Tokyo")

# A list of possible Olson time zones is shipped with R in the file returned by file.path(R.home("share"), "zoneinfo", "zone.tab").
# (That’s a file called zone.tab in a folder called zoneinfo inside the share directory where you installed R.)

# One can also give a manuel offset from UTC in the form "UTC + 4", "UTC - 5" (positive times are west of UTC)
strftime(now_ct, tz = "UTC-5") #More recent version of R will warn about unknown timezone but will perform the offset correctly
strftime(now_ct, tz = "-5") #Same as UTC-5 - if supported on the OS

# Or one can use the abbreviations
strftime(now_ct, tz = "EST") # Canadian Eastern Standard Time
strftime(now_ct, tz = "PST8PDT") #Pacific Standard Time w/ daylight savings

# Be Careful! strftime ignores time zone changes for POSIXlt dates. It is best to explicitly convert your dates to POSIXct before printing:
strftime(now_ct, tz = "Asia/Tokyo")
strftime(now_lt, tz = "Asia/Tokyo") #no zone change!
strftime(as.POSIXct(now_lt), tz = "Asia/Tokyo")

# Be also Cafeful about calling the concatenation function, c, with a POSIXlt argument.
# It will change the time zone to your local time zone. Calling c on a POSIXct argument, by contrast, will strip its time zone attribute completely.
# (Most other functions will assume that the date is now local, but be careful!)
c(now_ct, strftime(now_ct, tz = "America/Los_Angeles"), now_lt)
c(now_lt, now_ct)
c(now_ct, now_lt)




# ------
### Arithmetic with Dates and Times
# ------
# With POSIX classes one can add seconds:
now_lt + 3600; now_ct + 2*3600
# With the date class one can add days
now_date + 3600

# Subtraction gives the difference between two dates:
(now_lt + 54) - now_ct
# The result has the class "difftime". It stores the difference as a number with a unit (which is chosen "appropriately").
# To have more control over the units one can use the "difftime" function
difftime(now_lt + 54, now_ct, units = "hours")
difftime(now_lt + 54, now_ct, units = "weeks")
difftime(now_lt + 54, now_ct, units = "auto") # will do the standard behaviour. Here this is seconds.

# one can compare dates (be careful not to compare date and POSIX:
now_lt == now_ct
now_date + 2 > now_date

# Also the seq function works with POSIX dates:
seq_of_dates <- seq(now_ct, now_lt + 3600, by="1 min")

# One can also repeat dates, round dates, cut dates or calculate summary statistics, like mean and summary.
rep(now_ct,3)
round(now_ct, "hours")
round(now_ct, "min")
round(now_ct, "days")
cut(seq_of_dates, breaks = "min")
mean(seq_of_dates)
summary(seq_of_dates)

# To see many of the possibilities check
methods(class = "POSIXt") #and
methods(class = "Date")




# ------
### The lubridate package
# ------
# This package simplifies working with dates
# install.packages("lubridate")
library(lubridate)

# For example there is the ymd-function
ymd("2017 kjflasjfel 10 fasdfasdfs 29")
# where it parses the date on Year Month Day - there should only be three numbers
ymd("2017 kjflasjfel 10 fasdfasdfs 29 kjldjfaklefawjlk 19")

# There are analogous functions for other sequences
myd("02 kjflasjfel 2010 fasdfasdfs 22")
mdy("02 kjflasjfel 20 fasdfasdfs 22") # if one has year as a two digit number it will assume it is in the 21st century

# The parsing works also for vectors
(dates <- ymd(c("2017 kjflasjfel 10 fasdfasdfs 29", "2089-03-02", "2012 . 04 . 20")))

# There are also functions for time 
ymd_hms("2017 kjflasjfel 10 fasdfasdfs 29, 12:34:21")

# parse_date_time lets you give a more exact specification
parse_date_time("2017---02---12", "%Y---%m---%d", exact = TRUE)
# but it can also be used with short forms
parse_date_time("2017---02---12", "Ymd") # = ymd function


# To get a certain pattern for formatting, use the stamp function. It returns a function that you can use.
format_date <- stamp("2017 kjflasjfel 10 fasdfasdfs 29")
format_date(ymd("2019,12,2"))


### Ranges
# There are three different variable types to deal with ranges of time

## Duration -- specifies time spans as multiples of seconds
duration_one_to_ten_years <- dyears(1:10)
(today() + duration_one_to_ten_years) # note the jump for leap years!
# there is also dminutes, dseconds etc.

## Period -- specifies time spans according to clock time
(period_one_to_ten_years <- years(1:10))
(today() + period_one_to_ten_years) # note that we always stay on the same date!
# there is also minutes, seconds etc.

## Intervals -- a beginning and an end, mostly used for specifying periods or durations when one knows the start and end dates
start_date <- ymd("2016-01-01")
(interval_leap_year_duration <- interval(
  start_date,
  start_date + dyears(1)
))
(interval_leap_year_period <- interval(
  start_date,
  start_date + years(1)
))
as.period(interval_leap_year_duration)
as.period(interval_leap_year_period)

# One can use the % %-operations to work with intervals
an_interval <- ymd("2012-02-28") %--% ymd("2012-03-01") #specify an interval
ymd("2012-02-29") %within% an_interval # check if a date is in the interval
is.difftime(an_interval)
is.interval(an_interval)


### Dealing with time zones
with_tz(now_lt, tz = "America/Los_Angeles") # prints it explicitely
strftime(now_lt, tz = "America/Los_Angeles")

force_tz(now_lt, tz = "America/Los_Angeles") # to update incorrect time zones

OlsonNames() #a list of all olson names

# There are also other handy functions --- see also ?lubridate
floor_date(today(), "year")
ceiling_date(today(), "year")






# ------
### Exercises:
# ------

# Exercise 11-1
# Parse the birth dates of the Beatles, and print them in the form
# “AbbreviatedWeekday DayOfMonth AbbreviatedMonthName TwoDigitYear” (for example, “Wed 09 Oct 40”).
#Their dates of birth are given in the following table.

# Beatle Birth date
# Ringo Starr 1940-07-07
# John Lennon 1940-10-09
# Paul McCartney 1942-06-18
# George Harrison 1943-02-25
# [10]

stamp_function <- stamp("Wed 09 Oct 40")
parsed <- c(ymd("1940-07-07"), ymd("1940-10-09"), ymd("1942-06-18"), ymd("1943-02-25"))
(out_string <- strftime(parsed, "%a %d %b %y"))

# Exercise 11-2
# Programmatically read the file that R uses to find Olson time zone names. The
# examples in the ?Sys.timezone help page demonstrate how to do this. Find the
# name of the time zone for your location. [10]
tzfile <- file.path(R.home("share"), "zoneinfo", "zone.tab")
tzones <- read.delim(
  tzfile,
  row.names = NULL,
  header = FALSE,
  col.names = c("country", "coords", "name", "comments"),
  as.is = TRUE,
  fill = TRUE,
  comment.char = "#"
)
View(tzones)

# Exercise 11-3
# Write a function that accepts a date as an input and returns the astrological sign of
# the zodiac corresponding to that date. The date ranges for each sign are given in
# the following table. [15]

# Zodiac sign Start date End date
# Aries March 21 April 19
# Taurus April 20 May 20
# Gemini May 21 June 20
# Cancer June 21 July 22
# Leo July 23 August 22
# Virgo August 23 September 22
# Libra September 23 October 22
# Scorpio October 23 November 21
# Sagittarius November 22 December 21
# Capricorn December 22 January 19
# Aquarius January 20 February 18
# Pisces February 19 March 20



zodiac_signs <- function(x)
{
  zodiac_interval <- c(parse_date_time("21-03", "dm") %--% parse_date_time("19-04", "dm")
                       ,parse_date_time("20-04", "dm") %--% parse_date_time("20-05", "dm")
                       ,parse_date_time("21-05", "dm") %--% parse_date_time("20-06", "dm")
                       ,parse_date_time("21-06", "dm") %--% parse_date_time("22-07", "dm")
                       ,parse_date_time("23-07", "dm") %--% parse_date_time("22-08", "dm")
                       ,parse_date_time("23-08", "dm") %--% parse_date_time("22-09", "dm")
                       ,parse_date_time("23-09", "dm") %--% parse_date_time("22-10", "dm")
                       ,parse_date_time("23-10", "dm") %--% parse_date_time("21-11", "dm")
                       ,parse_date_time("22-11", "dm") %--% parse_date_time("21-12", "dm")
                       ,parse_date_time("22-12", "dm") %--% parse_date_time("19-01", "dm")
                       ,parse_date_time("20-01", "dm") %--% parse_date_time("18-02", "dm")
                       ,parse_date_time("19-02", "dm") %--% parse_date_time("20-03", "dm"))
  signs <- c("Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Sagittarius",
    "Capricorn",
    "Aquarius",
    "Pisces")
  
  normalized_date <- parse_date_time(strftime(x, "%d%m"), "dm") #there seems to be 
  
  signs[normalized_date %within% zodiac_interval]
}

