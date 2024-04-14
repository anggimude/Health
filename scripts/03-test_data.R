#### Preamble ####
# Purpose: Tests cleaned data - sum_sta
# Author: Hyuk Jang
# Date: 18 April 2024
# Contact: hyuk.jang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# Any other information needed? 


#### Workspace setup ####
library(tidyverse)


#### Test data ####
# checks if region/income/sex column is in characters
sum_sta$`Region/Income/Sex` |> class() == "character"
# checks if Age-standardized suicide rates (per 100 000 population) is in numeric
sum_sta$`Age-standardized suicide rates (per 100 000 population)` |> class() == "numeric"
# checks if Age_85+ is in numeric
sum_sta$`Age_85+` |> class()  == "numeric"
# checks if Age_75-84 is in numeric
sum_sta$`Age_75-84` |> class() == "numeric"
# checks if Age_65-74 is in numeric
sum_sta$`Age_65-74` |> class() == "numeric"
# checks if Age_55-64 is in numeric
sum_sta$`Age_55-64` |> class() == "numeric"
# checks if Age_45-54 is in numeric
sum_sta$`Age_45-54` |> class() == "numeric"
# checks if Age_35-44 is in numeric
sum_sta$`Age_35-44` |> class() == "numeric"
# checks if Age_25-34 is in numeric
sum_sta$`Age_25-34` |> class() == "numeric"
# checks if Age_15-24 is in numeric
sum_sta$`Age_15-24` |> class() == "numeric"
# checks if the dataset has 13 rows
if (nrow(sum_sta) == 13) {
  print(TRUE)
} else {
  print(FALSE)
}
# checks if the dataset has 10 columns
if (ncol(sum_sta) == 10) {
  print(TRUE)
} else {
  print(FALSE)
}