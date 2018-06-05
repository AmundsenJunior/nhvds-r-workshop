# R Training - New Haven Data Science
# Session 3 - 6/4/18
# https://rpubs.com/illya_UB/394512
# Shiny Apps

packages <- c('shiny', 'shinydashboard', 'tidyverse')
install.packages(packages)

# Components
# ui.R - what the user sees, and how/where they interact
# server.R - backend engine between computation & data
# global.R - sometimes needed, but optional for connecting to external resources

# Create a graph w/ggplot2

library(tidyverse)

# input parameters
hist_var <- 'mpg'
hist_title <- 'my title'

# output to render
ggplot(mtcars) +
    geom_histogram(aes_string(hist_var)) +
    labs(title = hist_title)


# RStudio > New > Shiny Web App > Single-File > "nhvds_1" > creates app.R
# create a shiny app to display a histogram on changing inputs



# New shiny app > nhvds_2
# shiny app to display mtcars table on changing inputs


# New Shiny app > data upload app > nhvds_3
write.csv(mtcars, file = '/home/srussell/dev/r/nhvds-r-workshop/car_data.csv', row.names = F)


# Create Shiny dashboard
# github.com/rstudio/shiny-examples/087-crandash