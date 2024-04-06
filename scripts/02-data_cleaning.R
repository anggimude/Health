#### Preamble ####
# Purpose: Cleans raw data into analyzed data we can use
# Author: Hyuk Jang
# Date: 18 April 2024
# Contact: hyuk.jang@mail.utoronto.ca
# License: MIT
# Pre-requisites: install packages 'tidyverse', 'dplyr', and 'arrow'


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)

#### Clean data ####
# Read in the data
suicide_ag_data <- read_csv("data/raw_data/suicide_ag_data.csv")
suicide_raw_data <- read_csv("data/raw_data/suicide_raw_data.csv")

# Function to extract the number before the opening square bracket
extract_number <- function(x) {
  gsub("\\[.*", "", x)
}

# Remove the range of suicide rates and keep the crude value
sr_data <- suicide_raw_data |>
  select(`...1`, `...2`, `Age-standardized suicide rates (per 100 000 population)...3`) |>
  mutate(
    `Age-standardized suicide rates (per 100 000 population)...3` = extract_number(`Age-standardized suicide rates (per 100 000 population)...3`)
  )
suicide_ag_data <- suicide_ag_data[!is.na(suicide_ag_data$`...1`), ]

# Select the same number of rows from each dataset
n_rows <- min(nrow(sr_data), nrow(suicide_ag_data))

# Match the number of rows of the datasets that will be merged
cleaned_sr_data <- head(sr_data, n_rows)
cleaned_ag_data <- head(suicide_ag_data, n_rows)

# Merge the two tables
merged_table <- dplyr::bind_cols(cleaned_sr_data, cleaned_ag_data)

# Creating a mapping lower income economies
lower_income <- c(
  "Afghanistan", "Democratic People's Republic of Korea", "South Sudan",
  "Burkina Faso", "Liberia", "Sudan",
  "Burundi", "Madagascar", "Syrian Arab Republic",
  "Central African Republic", "Malawi", "Togo",
  "Chad", "Mali", "Uganda",
  "Democratic Republic of the Congo", "Mozambique", "Yemen",
  "Eritrea", "Niger", "Ethiopia",
  "Rwanda", "Gambia", "Sierra Leone",
  "Guinea-Bissau", "Somalia"
)

# Creating a mapping lower middle income economies
lower_middle <- c(
  "Angola", "Jordan", "Philippines", "Algeria", "India",
  "Samoa", "Bangladesh", "Iran (Islamic Republic of)", "Sao Tome and Principe",
  "Benin", "Kenya", "Senegal", "Bhutan", "Kiribati", "Solomon Islands",
  "Bolivia (Plurinational State of)", "Kyrgyzstan", "Sri Lanka", "Cabo Verde", "Lao People's Democratic Republic",
  "United Republic of Tanzania", "Cambodia", "Lebanon", "Tajikistan", "Cameroon", "Lesotho",
  "Timor-Leste", "Comoros", "Mauritania", "Tunisia", "Congo",
  "Micronesia (Federated States of)", "Ukraine", "Cote d'Ivoire", "Mongolia",
  "Uzbekistan", "Djibouti", "Morocco", "Vanuatu", "Egypt",
  "Myanmar", "Viet Nam", "Eswatini", "Nepal", "Zambia", "Ghana", "Nicaragua",
  "Zimbabwe", "Guinea", "Nigeria", "Haiti", "Pakistan", "Honduras",
  "Papua New Guinea"
)

# Creating a mapping upper middle income economies
upper_middle <- c(
  "Albania", "Fiji", "North Macedonia", "Argentina", "Gabon",
  "Palau", "Armenia", "Georgia", "Paraguay", "Azerbaijan",
  "Grenada", "Peru", "Belarus", "Guatemala", "Russian Federation",
  "Belize", "Indonesia", "Serbia", "Bosnia and Herzegovina", "Iraq",
  "South Africa", "Botswana", "Jamaica", "Saint Lucia", "Brazil",
  "Kazakhstan", "Saint Vincent and the Grenadines", "Bulgaria", "Kosovo",
  "Suriname", "China", "Libya", "Thailand", "Colombia", "Malaysia",
  "Tonga", "Costa Rica", "Maldives", "Turkiye", "Cuba", "Marshall Islands",
  "Turkmenistan", "Dominica", "Mauritius", "Tuvalu", "Dominican Republic",
  "Mexico", "West Bank and Gaza", "El Salvador", "Republic of Moldova", "Equatorial Guinea",
  "Montenegro", "Ecuador", "Namibia", "Venezuela (Bolivarian Republic of)"
)

# Creating a mapping high income economies
high_income <- c(
  "American Samoa", "Germany", "Oman", "Andorra", "Gibraltar",
  "Panama", "Antigua and Barbuda", "Greece", "Poland", "Aruba",
  "Greenland", "Portugal", "Australia", "Guam", "Puerto Rico",
  "Austria", "Hong Kong SAR, China", "Qatar", "Bahamas", "Hungary",
  "Romania", "Bahrain", "Iceland", "San Marino", "Barbados", "Ireland",
  "Saudi Arabia", "Belgium", "Isle of Man", "Seychelles", "Bermuda",
  "Israel", "Singapore", "British Virgin Islands", "Italy", "Sint Maarten (Dutch part)",
  "Brunei Darussalam", "Japan", "Slovakia", "Canada", "Republic of Korea",
  "Slovenia", "Cayman Islands", "Kuwait", "Spain", "Channel Islands",
  "Latvia", "St. Kitts and Nevis", "Chile", "Liechtenstein", "St. Martin (French part)",
  "Croatia", "Lithuania", "Sweden", "Curaçao", "Luxembourg", "Switzerland",
  "Cyprus", "Macao SAR, China", "Taiwan, China", "Czechia", "Malta",
  "Trinidad and Tobago", "Denmark", "Monaco", "Turks and Caicos Islands",
  "Estonia", "Nauru", "United Arab Emirates", "Faroe Islands", "Netherlands (Kingdom of the)",
  "United Kingdom of Great Britain and Northern Ireland", "Finland", "New Caledonia", "United States of America", "France",
  "New Zealand", "Uruguay", "French Polynesia", "Northern Mariana Islands",
  "Virgin Islands (U.S.)", "Guyana", "Norway"
)

# Make a mapping for countries in Africa
Africa <- c("Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", 
  "Cabo Verde", "Cameroon", "Central African Republic", "Chad", 
  "Comoros", "Congo", "Democratic Republic of the Congo", 
  "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Eswatini", "Ethiopia", 
  "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", 
  "Cote d'Ivoire", "Kenya", "Lesotho", "Liberia", 
  "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", 
  "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", 
  "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", 
  "South Sudan", "Sudan", "United Republic of Tanzania", "Togo", "Tunisia", "Uganda", "Zambia", 
  "Zimbabwe")

# Make a mapping for countries in Asia
Asia <- c("Afghanistan", "Armenia", "Azerbaijan", "Bahrain", "Bangladesh", "Bhutan", 
     "British Indian Ocean Territory", "Brunei Darussalam", "Cambodia", "China", "Cyprus", 
     "Egypt", "Georgia", "Hong Kong", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", 
     "Israel", "Japan", "Jordan", "Kazakhstan", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", 
     "Lebanon", "Macau", "Malaysia", "Maldives", "Mongolia", "Myanmar", "Nepal", 
     "Democratic People's Republic of Korea", "Oman", "Pakistan", "Palestine", "Philippines", "Qatar", 
     "Russian Federation", "Saudi Arabia", "Singapore", "Republic of Korea", "Sri Lanka", "Syrian Arab Republic", 
     "Taiwan", "Tajikistan", "Thailand", "Timor-Leste", "Turkiye", "Turkmenistan", 
     "United Arab Emirates", "Uzbekistan", "Viet Nam", "Yemen")

# Make a mapping for countries in Europe
Europe <- c("Albania", "Andorra", "Armenia", "Austria", "Azerbaijan", "Belarus", 
            "Belgium", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Cyprus", 
            "Czechia", "Denmark", "Estonia", "Finland", "France", "Georgia", 
            "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", 
            "Kazakhstan", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", 
            "Malta", "Republic of Moldova", "Monaco", "Montenegro", "Netherlands (Kingdom of the)", 
            "North Macedonia", "Norway", "Poland", "Portugal", "Romania", "Russia", 
            "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", 
            "Switzerland", "Turkey", "Ukraine", "United Kingdom of Great Britain and Northern Ireland", "Vatican City")

# Make a mapping for countries in North America
North_America <- c("Antigua and Barbuda", "Bahamas", "Barbados", "Belize", "Canada", 
                   "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "El Salvador", 
                   "Grenada", "Guatemala", "Haiti", "Honduras", "Jamaica", "Mexico", 
                   "Nicaragua", "Panama", "Saint Kitts and Nevis", "Saint Lucia", 
                   "Saint Vincent and the Grenadines", "Trinidad and Tobago", 
                   "United States of America")

# Make a mapping for countries in Oceania
Oceania <- c("Australia", "Fiji", "Kiribati", "Marshall Islands", 
              "Micronesia (Federated States of)", "Nauru", "New Zealand", 
              "Palau", "Papua New Guinea", "Samoa", "Solomon Islands", 
              "Tonga", "Tuvalu", "Vanuatu")

# Make a mapping for countries in South America
South_America <- c("Argentina", "Bolivia (Plurinational State of)", "Brazil", "Chile", "Colombia", 
                    "Ecuador", "Guyana", "Paraguay", "Peru", "Suriname", 
                    "Uruguay", "Venezuela (Bolivarian Republic of)")


# Clean the merged table; renaming, removing repeated columns, rows, mapping region and country income
cleaned_merged_table <- merged_table|>
  select(c(-...4, -...5))|>
  rename(
    Country = `...1`,
    Sex = `...2`,
    `Age_85+` = `Crude suicide rates (per 100 000 population)...6`,
    `Age_75-84` = `Crude suicide rates (per 100 000 population)...7`,
    `Age_65-74` = `Crude suicide rates (per 100 000 population)...8`,
    `Age_55-64` = `Crude suicide rates (per 100 000 population)...9`,
    `Age_45-54` = `Crude suicide rates (per 100 000 population)...10`,
    `Age_35-44` = `Crude suicide rates (per 100 000 population)...11`,
    `Age_25-34` = `Crude suicide rates (per 100 000 population)...12`,
    `Age_15-24` = `Crude suicide rates (per 100 000 population)...13`
  )|>
  slice(-1)|>
  mutate(
    Income_Group = case_when(
      Country %in% lower_income ~ "lower_income",
      Country %in% lower_middle ~ "lower_middle",
      Country %in% upper_middle ~ "upper_middle",
      Country %in% high_income ~ "high_income",
      TRUE ~ NA_character_
    )
  )|>
  mutate(
    Region = case_when(
      Country %in% Africa ~ "Africa",
      Country %in% Europe ~ "Europe",
      Country %in% North_America ~ "North America",
      Country %in% Oceania ~ "Oceania",
      Country %in% South_America ~ "South America",
      Country %in% Asia ~ "Asia",
      TRUE ~ NA_character_
  )
)


# Save table as parquet, csv file
write_csv(cleaned_merged_table, "data/analysis_data/cleaned_merged_table.csv")
write_parquet(cleaned_merged_table, "data/analysis_data/cleaned_merged_table.parquet")