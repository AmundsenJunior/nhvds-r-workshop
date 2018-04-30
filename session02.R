# R Training - New Haven Data Science
# Session 2 - 2/5/18
# https://rpubs.com/illya_UB/356724
# Data Wrangling

rm(list=ls())
setwd("/home/srussell/dev/r")
dir()

library(dplyr)
library(tidyverse)
install.packages('AER')
library(AER)

data('Affairs') # extramarital affairs
affairs <- Affairs
summary(affairs)

# Wrangling Verbs

# arrange (sorting)
?arrange
sorted_by_rating <- arrange(affairs, rating)
head(sorted_by_rating)
sorted_by_desc_rating <- arrange(affairs, desc(rating))
head(sorted_by_desc_rating)
sorted_by_desc_rating <- affairs %>% arrange(desc(rating)) # includes 'then' pipe
head(sorted_by_desc_rating)

sorted_by_desc_affairs <- affairs %>% arrange(desc(affairs))
head(sorted_by_desc_affairs)
sorted_by_desc_affairs_and_religiousness <- affairs %>% arrange(desc(affairs), religiousness)
head(sorted_by_desc_affairs_and_religiousness)
tail(sorted_by_desc_affairs_and_religiousness)

# filtering
?filter

filtered_rating_5 <- affairs %>% filter(rating == 5)
nrow(filtered_rating_5)

filtered_rating_3 <- affairs %>% filter(rating > 2, rating < 4)
nrow(filtered_rating_3)

filtered_children <- affairs %>% filter(children == "yes")
head(filtered_children)

filtered_affairs_religiousness_5_rating_5 <- affairs %>% filter(affairs > 0, religiousness == 5, rating == 5)
head(filtered_affairs_religiousness_5_rating_5)
nrow(filtered_affairs_religiousness_5_rating_5)
filtered_affairs_religiousness_5_rating_5_children <- filtered_affairs_religiousness_5_rating_5 %>% filter(children == "yes")
nrow(filtered_affairs_religiousness_5_rating_5_children)

# mutate (create new column)

cheater <- affairs %>% mutate(cheater = ifelse(affairs > 0, 1, 0))
head(arrange(cheater, affairs))
head(arrange(cheater, desc(affairs)))

cheater <- affairs %>%
  mutate(cheater = ifelse(affairs > 0, 1, 0),
         age_when_married = age - yearsmarried)
head(arrange(cheater, affairs))
summary(cheater$age_when_married)
summary(cheater$age)

cheater <- affairs %>%
  mutate(cheater = ifelse(affairs >= 6, 1, 0),
         religiousness_over_rating = religiousness / rating)
summary(cheater)


# multiple verbs, taking advantage of piping
cheater_rel5 <- affairs %>%
  mutate(cheater = ifelse(affairs > 0, 1, 0)) %>%
  filter(religiousness == 5,
         cheater == 1)
nrow(cheater_rel5)

mean_cheater <- mean(cheater$cheater)
str(mean_cheater)

# dplyr syntax
mean_cheater <- cheater %>% summarize(mean_cheater = mean(cheater))
mean_cheater

summarize_cheater <- cheater %>%
  summarize(sum_cheater = sum(cheater),
            mean_rating = mean(rating))
summarize_cheater


# group_by
cheater_by_rel <- cheater %>%
  group_by(religiousness) %>%
  summarize(proportion_cheater = mean(cheater))
cheater_by_rel

cheater_by_rel <- cheater %>%
  group_by(religiousness) %>%
  mutate(proportion_cheater = mean(cheater)) %>% # group_by then mutate to get a grouped calculated value and apply directly back into dataframe
  select(1:3, religiousness, cheater, proportion_cheater) %>% # select data by columns
  ungroup() # ungroup in order to not carry over the grouping
head(cheater_by_rel)

?dplyr::select
cheater %>%
  select(starts_with('r'))


cheaters_children <- cheater %>%
  group_by(children) %>%
  summarize(mean_rel = mean(religiousness),
            mean_rating = mean(rating),
            mean_cheater = mean(cheater))
cheaters_children

cheaters_children <- cheater %>%
  group_by(children) %>%
  mutate(mean_rel = mean(religiousness),
         mean_rating = mean(rating),
         mean_cheater = mean(cheater))
cheaters_children



# JOINS

band_members
band_instruments

# inner join - defaults to a matching column, joins matches from both tables
inner <- inner_join(band_members, band_instruments)
inner

# left join - includes all obs from left table, and leaves empty any unjoined vales from second table
left <- left_join(band_members, band_instruments)
left

# semi join - show all rows from first table that have records in second table
semi <- semi_join(band_members, band_instruments)
semi

# anti join - everything from first table that doesn't match with second table
anti <- anti_join(band_members, band_instruments)
anti


# transposing - gather
# pivot rows to columns & vice versa

# transposing - spread
# pivot back


# Next phase is parameterization
# Passing on values 

x <- 'children'
n6 <- cheater %>%
  group_by_(x) %>%
  mutate(mcheater = mean(cheater))
n6
