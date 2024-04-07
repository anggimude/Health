#### Preamble ####
# Purpose: Models... 
# Author: Hyuk Jang
# Date: 26 Mar 2024
# Contact: hyuk.jang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# Any other information needed? 


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(ggplot2)
library(modelsummary)
library(bayesplot)
library(parameters)
library(broom)

#### Read data ####
cleaned_merged_table <- read_csv("data/analysis_data/cleaned_merged_table.csv")

### Model data ####

# Fit Gaussian(normal) regression 
suicide_model_normal <- stan_glm(
  `Age-standardized suicide rates (per 100 000 population)` ~ Sex + `Age_85+` + `Age_75-84` + `Age_65-74` + `Age_55-64` + `Age_45-54` + `Age_35-44` + `Age_25-34` + `Age_15-24` + Income_Group + Region,
  data = cleaned_merged_table,
  family = gaussian(link = "identity")
)

# Fit multilevel Gaussian regression 
suicide_model_multilevel <- stan_glmer(
  `Age-standardized suicide rates (per 100 000 population)` ~ (1 | Country) + Sex + `Age_85+` + `Age_75-84` + `Age_65-74` + `Age_55-64` + `Age_45-54` + `Age_35-44` + `Age_25-34` + `Age_15-24` + Income_Group + Region,
  data = cleaned_merged_table,
  family = gaussian(link = "identity"),  
  prior = normal(location = 0, scale = 3, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 3, autoscale = TRUE),
  seed = 853
)

suicide_model <- stan_glmer(
  Country ~ Sex + `Age_85+` + `Age_75-84` + `Age_65-74` + `Age_55-64` + `Age_45-54` + `Age_35-44` + `Age_25-34` + `Age_15-24` + Income_Group + Region,
  data = cleaned_merged_table,
  family = gaussian(link = "identity"),  
  prior = normal(location = 0, scale = 3, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 3, autoscale = TRUE),
  seed = 853
)


# Save the multilevel model
saveRDS(
  suicide_model_multilevel,
  file = "suicide_model_multilevel.rds"
)
# Save the normal model
saveRDS(
  suicide_model_normal,
  file = "suicide_model_normal.rds"
)


view(suicide_model_multilevel)

library(rstanarm)
library(ggplot2)
library(modelsummary)
library(bayesplot)
library(parameters)
library(broom)
library(kableExtra)
model_summary <- modelsummary(
  list(
    "Multilevel" = suicide_model_multilevel
  )
)
view(model_summary)
modelsu
