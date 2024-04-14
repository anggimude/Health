#### Preamble ####
# Purpose: Models global suicide rates to income/region/sex and age groups using linear regression
# Author: Hyuk Jang
# Date: 18 April 2024
# Contact: hyuk.jang@mail.utoronto.ca
# License: MIT
# Pre-requisites: install packages 'tidyverse', 'rstanarm', 'ggplot2', 'modelsummary', and 'tidybayes'


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(ggplot2)
library(modelsummary)
library(tidybayes)

#### Read data ####
sum_sta <- read_csv("data/analysis_data/sum_sta.csv")
sum_sta_long <- read_csv("data/analysis_data/sum_sta_long.csv")

### Model data ####

# Plot the reshaped data
ggplot(sum_sta_long, aes(x = `Region/Income/Sex`, y = Suicide_Rate, color = Age_Group)) +
  geom_point() +
  ggtitle("Global Suicide Rates by Age, Region, Sex, and Income Group") +
  xlab("Region/Income Group/Sex and Age Group") +
  ylab("Suicide Rate") +
  theme_minimal()


# Fitting the data to a linear model
suicide_normal_model <- stan_glm(
  `Age-standardized suicide rates (per 100 000 population)` ~ `Region/Income/Sex` + `Age_85+` + `Age_75-84` + `Age_65-74` + `Age_55-64` + `Age_45-54` + `Age_35-44` + `Age_25-34` + `Age_15-24`,
  data = sum_sta,
  family = gaussian(link = "identity"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = 
    normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 123
)

modelsummary(
  list(
    "Gaussian(Normal)" = suicide_normal_model
  )
)

modelplot(suicide_normal_model, conf_level = 0.95) +
  labs(x = "95 per cent credibility interval")


# Save the linear model
saveRDS(
  suicide_normal_model,
  file = "models/suicide_normal_model.rds"
)

