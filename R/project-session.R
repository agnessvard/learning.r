source(here::here("R/package-loading.R"))

### note = #
### object assignment: arrow by typing "option -"

### vector: a string of things
c("a", "b")   # character vector
c(1, 2)       # number vector
1:10          # vector of 1 thru 10

### dataframe
head(iris) # first 6 lines of data

# view colnames
colnames(iris)

# view structure
str(iris)

# summary
summary(iris)

### linear model
lm # to view what is inside the model

### to create a section
# under the tab "code" -> insert section (or shift+commande+R) and specify a name. This will create the below line, a section that you can quickly go to
# data_wrangling ----------------------------------------------------------

# Object names

# Should be camel case
# DayOne
day_one
# dayone
day_one

# Should not over write existing function names
# T = TRUE, so don't name anything T
# T <- FALSE
false <- FALSE
# c is a function name already. Plus c is not descriptive
# c <- 9
number_value <- 9
# mean is a function, plus does not describe the function which is sum
# mean <- function(x) sum(x)
sum_vector <- function(x) sum(x)

# Spacing
# Commas should be in correct place
# x[,1]
# x[ ,1]
# x[ , 1]
x[, 1]
# Spaces should be in correct place
# mean (x, na.rm = TRUE)
# mean( x, na.rm = TRUE )
mean(x, na.rm = TRUE)
# function (x) {}
# function(x){}
function(x) {}
# height<-feet*12+inches
height <- feet * 12 + inches
# mean(x, na.rm=10)
mean(x, na.rm = 10)
# sqrt(x ^ 2 + y ^ 2)
sqrt(x^2 + y^2)
# df $ z
df$z
# x <- 1 : 10
x <- 1:10

# Indenting should be done after if, for, else functions
# if (y < 0 && debug)
# message("Y is negative")
if (y < 0 && debug)
  message("Y is negative")


# function ----------------------------------------------------------------

### type in "fun" and klick enter
# name <- function(variables) {
#}


summing <- function(a, b) {
  add_numbers <- a + b
  return(add_numbers)
}
summing(2, 2)

### access packages
#library()
#require()

usethis::use_r("package-loading")

library(tidyverse)

write_csv(iris, here::here("data/iris.csv"))
iris_data <- read_csv(here::here("data/iris.csv"))
iris_data

?write.csv

