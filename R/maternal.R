library(readr)
library(tidyverse)
library(dplyr)
library(purrr)
library(countrycode)


changeformat <- function(file, values){
  maternalmortality_data <- read_csv(file.path("data",file))
  subset_data <- maternalmortality_data %>%
    select(`Country Name`, `2000`:`2019`)
  
  long_data <- subset_data %>%
    pivot_longer(
      cols = `2000`:`2019`,         # Select the columns to pivot
      names_to = "Year",            # Name for the new "year" column
      values_to = values          # Name for the new "values" column
    ) %>%
    mutate(Year = as.numeric(Year)) # Convert the "Year" column to numeric
  return(long_data)
}

maternal_data <- changeformat("maternalmortality.csv","MatMor")
infant_data <- changeformat("infantmortality.csv","InfantR")
neonatal_data <- changeformat("neonatalmorta.csv","NeonatalR")
under5_data <- changeformat("under5mortality.csv","Under5R")

merge_data <- reduce(list(maternal_data, infant_data, neonatal_data, under5_data), function(x, y) full_join(x, y, by = c("Country Name", "Year")))

merge_data$ISO <- countrycode(merge_data$`Country Name`,
                            origin = "country.name",
                            destination = "iso3c")

