# A Linear Regression on Global Suicide Rates and Country Income, Region, Age, and Sex in 2019

## Overview

This repo provides a correlation between global suicide rates and its correlation to country income, region, age, and gender in 2019. Suicide has become a main cause of death globally over the past decades. This creates curiosity in what immutable factors may be affecting suicide rates. This paper looks into the regression between global suicide rates and sex, age, country income, and region. Our results show that there is a weak correlation to age and region/country income affect suicide rates more. Then further analysis is done by studying what factors generate such tendencies.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean, and model data.


## Statement on LLM usage

Chat GPT3.5 was used in parts of coding and writing. For coding, it was used in parts of `02-data_cleaning` and `04-model`. For writing, parts of the result and model section were written with the usage of LLM. The specific conversations of the usage of LLM can be seen in `other/llm`.  
