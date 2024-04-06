#### Preamble ####
# Purpose: Downloads and saves the data from 
# Author: Hyuk Jang
# Date: 18 April 2024
# Contact: hyuk.jang@mail.utoronto.ca
# License: MIT
# Pre-requisites: install packages 'readr' and 'tidyverse'.
 

#### Workspace setup ####
library(readr)
library(tidyverse)

#### Download data ####

# URL to download data
url_1 <- "https://apps.who.int/gho/athena/data/GHO/SDGSUICIDE?filter=COUNTRY:*;REGION:*;;AGEGROUP:YEARS15-24;AGEGROUP:YEARS25-34;AGEGROUP:YEARS35-44;AGEGROUP:YEARS45-54;AGEGROUP:YEARS55-64;AGEGROUP:YEARS65-74;AGEGROUP:YEARS75-84;AGEGROUP:YEARS85PLUS&ead=&x-sideaxis=COUNTRY;SEX&x-topaxis=GHO;YEAR;AGEGROUP&profile=crosstable&format=csv"

# Set the filename to save the downloaded data
suicide_age <- "suicide_ag_data.csv"

# Download the file
download.file(url_1, suicide_age, method = "auto")

# Read the downloaded CSV file
suicide_ag_data <- read_csv(suicide_age)

# URL to download data
url_2 <- "https://apps.who.int/gho/athena/data/xmart.csv?target=GHO/MH_12&profile=crosstable&filter=COUNTRY:*;REGION:*&ead=&x-sideaxis=COUNTRY;SEX&x-topaxis=GHO;YEAR"

# Set the filename to save the downloaded data
suicide_year <- "suicide_raw_data.csv"

# Download the file
download.file(url_2, suicide_year, method = "auto")

# Read the downloaded CSV file
suicide_raw_data <- read_csv(suicide_year)


#### Save data ####

# Write the downloaded data to a CSV file
write_csv(suicide_raw_data, "data/raw_data/suicide_raw_data.csv") 

write_csv(suicide_ag_data, "data/raw_data/suicide_ag_data.csv") 

