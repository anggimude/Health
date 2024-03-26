#### Preamble ####
# Purpose: Downloads and saves the data from 
# Author: Hyuk Jang
# Date: 26 Mar 2024
# Contact: hyuk.jang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# Any other information needed? 

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)


#### Download data ####




#### Save data ####

# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "inputs/data/raw_data.csv") 

         
