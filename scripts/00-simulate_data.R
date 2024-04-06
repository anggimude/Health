#### Preamble ####
# Purpose: Simulates the cleaned data for analysis 
# Author: Hyuk Jang
# Date: 18 April 2024
# Contact: hyuk.jang@mail.utoronto.ca
# License: MIT
# Pre-requisites: install packages 'tidyverse' and 'dplyr'


#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Simulate data ####

# Set seed for reproducibility
set.seed(123)

# Set seed for reproducibility
set.seed(123)

# Define the list of countries
countries <- c("Country_A", "Country_B", "Country_C")

# Define the 10-year age groups
age_groups <- c("0-9", "10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80-89", "90+")

# Define genders
genders <- c("Male", "Female")

# Initialize an empty list to store simulated data
simulated_data <- list()

# Simulate data for each country, gender, and age group
for (country in countries) {
  for (gender in genders) {
    for (age_group in age_groups) {
      # Simulate suicide rate (in per 100,000 population)
      simulated_rate <- runif(1, min = 0.1, max = 20)  
      
      # Append simulated data to the list
      simulated_data[[length(simulated_data) + 1]] <- data.frame(country = country,
                                                                 gender = gender,
                                                                 age_group = age_group,
                                                                 suicide_rate = simulated_rate)
    }
  }
}

# Combine the data frames in the list into a single data frame
simulated_data <- do.call(rbind, simulated_data)

# View the first few rows of the simulated data
head(simulated_data)



