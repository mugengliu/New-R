library(readr)
library(tidyverse)
library(dplyr)
maternalmortality_data <- read_csv("original/maternalmortality.csv")

subset_data <- maternalmortality_data %>%
  select(`Country Name`, `2000`:`2019`)

long_data <- subset_data %>%
  pivot_longer(
    cols = `2000`:`2019`,         # Select the columns to pivot
    names_to = "Year",            # Name for the new "year" column
    values_to = "MatMor"          # Name for the new "values" column
  ) %>%
  mutate(Year = as.numeric(Year)) # Convert the "Year" column to numeric

head(subset_data)


