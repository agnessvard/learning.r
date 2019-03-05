#usethis::use_r("exercises-wrangling")

# Load the packages
library(tidyverse)
library(NHANES)

# Check column names
colnames(NHANES)

# Look at contents
str(NHANES)
glimpse(NHANES)

# See summary
summary(NHANES)

# Look over the dataset documentation
?NHANES

### The pipe operator
# %>%

# these two are the same
colnames(NHANES)

NHANES %>%
  colnames()

# standard R way of "chaining" functions together
glimpse(head(NHANES))

# the pipe way of "chaining"
NHANES %>%
  head() %>%
  glimpse()


# mutate() function -------------------------------------------------------

### Mutating: transforming or adding variables
# modify an existing variable
# changes won't be saved
NHANES %>%
  mutate(Height = Height / 100)

# changes will be saved since the changes are assigned to "NHANES_changed" (new dataset)
# variables "Height" will be overwritten
NHANES_changed <- NHANES %>%
  mutate(Height = Height / 100)

# NHANES_changed <-  NHANES # to undo the changes to the Height-variable
# changes will be saved since the changes are assigned to "NHANES_changed" (new dataset)
# new variable "Height_meters" will be created
NHANES_changed <- NHANES %>%
  mutate(Height_meters = Height / 100)

# or create a new variable based on a condition
NHANES_changed <- NHANES_changed %>%
  mutate(HighlyActive = if_else(PhysActiveDays >= 5, "Yes", "No"))
#  the above row can be edited to include OR (|) / AND (&) in the if_else criteria
# mutate(HighlyActive = if_else(PhysActiveDays >= 5 & ... "Yes", "No"))

# create or replace multiple variables by using the ","
NHANES_changed <- NHANES_changed %>%
  mutate(new_column = "only one variable",
         "height_meters2" = Height / 100,
         UrineVolAverage = (UrineVol1 + UrineVol2 /2))


# exercise 2 --------------------------------------------------------------

# 1. Create a new variable called “UrineVolAverage” by calculating the
#   average urine volumne (from “UrineVol1” and “UrineVol2”).
# 2. Modify/replace the “Pulse” variable to beats per second
#   (currently is beats per minute).
# 3. Create a new variable called “YoungChild” when age is less than 6 years.
# # Check the names of the variables
colnames(NHANES)

# Pipe the data into mutate function and:
NHANES_modified <- NHANES %>% # dataset
  mutate(
    # 1. Calculate average urine volume
    UrineFolAverage = (UrineVol1 + UrineVol2 /2),
    # 2. Modify Pulse variable
    Pulse_second = Pulse / 60,
    # 3. Create YoungChild variable using a condition
    YoungChild = if_else(Age < 6, "Yes", "No")
  )

NHANES_modified


# select(): select specific data by the variable ----------------------------------------------------------------

### select columns / variables by name, without quotes
# dataset not saved
NHANES %>%
  select(Age, Gender, BMI)

# dataset saved
NHANES_characteristics <- NHANES %>%
  select(Age, Gender, BMI)

# to not select a variable, use (-)
NHANES %>%
  select(-HeadCirc)

# to select similar names, use "matching" functions
NHANES %>%
  #select variables that starts with "BP" and variables that contain "Vol"
  select(starts_with("BP"), contains("Vol"))

?select_helpers


# Rename(): rename specific columns ---------------------------------------

# rename using the form: "newname = oldname"
# not saved (have to assign it ( <- ) to save it)?++
NHANES %>%
  rename(NumberBabies = nBabies)


# filter(): filtering/subsetting the data by row --------------------------

# when gender is equal to
# not saved
NHANES %>%
  filter(Gender == "female")

# when gender is NOT equal to
# not saved
NHANES %>%
  filter(Gender != "female")

# when BMI is equal to
# not saved
NHANES %>%
  filter(BMI == 25)

# when BMI is greater than
# not saved
NHANES %>%
  filter(BMI >= 25)

# when BMI is 25 AND Gender is female
# not saved
NHANES %>%
  filter(BMI == 25 & Gender == "female")

# when BMI is 25 OR Gender is female
# not saved
NHANES %>%
  filter(BMI == 25 | Gender == "female")


# arrange(): sorting/(re)arranging your data by column --------------------

# ascending order by age
# by default, ascending order (lowest number on top)
NHANES %>%
  arrange(Age) %>%
  select(Age)

NHANES %>%
  arrange(Age, Gender) %>%
  select(Age, Gender)

# descending order (highest number on top)
NHANES %>%
  arrange(desc(Age), Gender) %>%
  select(Age, Gender)


# Exercise: filtering and logic, arranging and selecting ------------------
#
# 1. Filter so only those with BMI more than 20 and less than 40 and keep
#   only those with diabetes.
# 2. Filter to keep those who are working (“Work”) or those who are renting
#   (“HomeOwn”) and those who do not have diabetes. Select the variables
#   age, gender, work status, home ownership, and diabetes status.
# 3. Using sorting and selecting, find out who has had the most number
#   of babies and how old they are.

# To see values of categorical data
summary(NHANES)

# 1. BMI between 20 and 40 and who have diabetes
NHANES_BMI_Diabetes <- NHANES %>%
  # format: variable >= number
  filter(BMI >= 20 & BMI <= 40 & Diabetes == "Yes")

# 2. Working or renting, and not diabetes
NHANES_work_rent_no_diabetes <- NHANES %>%
  filter(Work == "Working" | HomeOwn == "Rent" & Diabetes == "No") %>%
  select(Work, HomeOwn, Diabetes)

# 3. How old is person with most number of children.
NHANES %>%
  arrange(desc(nBabies)) %>%
  select(Age, nBabies)

# group_by(), summarise(): create a summary of the data, alone or  --------

# summarise() by itself
# na = not available
# rm = remove
# na.rm = TRUE = remove not available cases
NHANES %>%
  summarise(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm = TRUE))

# combine with group_by()
NHANES %>%
  group_by(Gender) %>%
  summarise(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm = TRUE))

NHANES %>%
  group_by(Gender, Diabetes) %>%
  summarise(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm = TRUE))

# you can also choose to summarise median, sd etc.


# gather(): converting from wide to long form ------------------------------------------------------------------
# The arguments for gather are:
# 1. The name of a new column that contains the original column names
# 2. The name of a new column that contains the values from the original columns
# 3. The original columns we either want or do not want “gathered” up.

table4b

# using pipe operator "%>%" is the reason why you can skip 1
# (the name of teh column that contains the original column names)
table4b %>%
  gather(year, population, -country)

# This does the same:
table4b %>%
  gather(year, population, `1999`, `2000`)

# keep only  variables that are of interest
nhanes_char <-  NHANES %>%
  select(SurveyYr, Gender, Age, Weight, Height, BMI, BPSysAve)
nhanes_char

# convert variables to long form, excluding survey year and gender
nhanes_long <- nhanes_char %>%
  gather(Measure, Value, -SurveyYr, -Gender)
nhanes_long

# use summarise to summarise the measurements in nhanes_long
nhanes_long %>%
  group_by(SurveyYr, Gender, Measure) %>%
  summarise(MeanValues = mean(Value, na.rm = TRUE))


# spread() converting from long to wide form ------------------------------

table2

# Convert to wide form
table2 %>%
  spread(key = type, value = count)
