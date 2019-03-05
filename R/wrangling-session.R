# load packages from the "package-loading.R script
source(here::here("R/package-loading.R"))

glimpse(NHANES)

NHANES <- NHANES
View(NHANES)

# Load the packages
library(tidyverse)
library(NHANES)

# Check column names
colnames(NHANES)

# Look at contents
str(NHANES)
glimpse(NHANES)

# See summary
summary(___)

# Look over the dataset documentation
?___
