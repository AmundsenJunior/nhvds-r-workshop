# R Training - New Haven Data Science
# Session 1 11/29/17
# https://rpubs.com/illya_UB/335455

rm(list=ls())
setwd("/home/srussell/dev/r")
dir()

# Vectors
v1 <- c(1, 5, 7)
v2 <- 2
v3 <- 3
v4 <- v2 + v3

v5 <- c(v1, v4)

head(mtcars)
summary(mtcars)
mpg <- mtcars$mpg
mean(mpg)
min(mpg)
max(mpg)
sum(mpg)

library("ggplot2")
my_first_plot <- ggplot(mtcars) +
  geom_smooth(aes(mpg, wt))
my_first_plot

# histogram
hist(mtcars$mpg)
hist(mtcars$mpg,
     xlab = 'Miles per Gallon',
     ylab='Number of Cars',
     main='Histogram of MPG')
hist(mtcars$wt)

#scatterplot
plot(mtcars$wt, mtcars$mpg)
boxplot(mtcars$wt, mtcars$mpg)
summary(mtcars$wt)

# functions
circ_area <- function(diameter) {
  pi * (diameter/2) ^ 2
}

circ_area(3)
circ_area(v1)
areas_v5 <- circ_area(v5)
areas_v5

# lists
# a box of objects
# define an empty list
noahs_singles_arc <- list()
# inserting objects
noahs_singles_arc$char_vector <- c("hello", "goodbye")
noahs_singles_arc$mtcars <- mtcars
noahs_singles_arc$circ_area <- circ_area
noahs_singles_arc$v5 <- v5
summary(noahs_singles_arc)

noahs_singles_arc$circ_area(noahs_singles_arc$v5)
noahs_singles_arc[4]

# packages
install.packages('tidyverse')
library(tidyverse)

# data wrangling and exploration
# dataset: HR Employee Attrition and Performance
# https://www.ibm.com/communities/analytics/watson-analytics-blog/hr-employee-attrition/
library(readxl)
employees_data <- read_excel("~/dev/r/nhvds-r-workshop/session01-plotting/WA_Fn-UseC_-HR-Employee-Attrition.xlsx")
View(employees_data)
summary(employees_data)
str(employees_data)

# sort the data
employees_age <- arrange(employees_data, desc(Age))
View(employees_age)

# select first and last fields with native R
employees_first_last <- employees_data[, c(1,35)]
View(employees_first_last)

# select first and last fields with dplyr.select function
employees_first_last_select <- select(employees_data, Age, YearsWithCurrManager)
View(employees_first_last_select)

# create new field in employees_data with native R 
employees_data$minc_over_age <- employees_data$MonthlyIncome/employees_data$Age

# create a new field in employees_data with dplyr.mutate function
employees_data$minc_over_age_mutate <- mutate(employees_age, minc_over_age = MonthlyIncome/Age)

# chain functions with "then" operator (%>%)
# take dataset, then select two fields, then mutate a new field, altogether the final result into a new object
new <- employees_data %>%
  select(MonthlyIncome, Age) %>%
  mutate(minc_over_age = MonthlyIncome/Age)
View(new)
