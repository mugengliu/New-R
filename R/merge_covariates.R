library(readr)
library(dplyr)

source("R/analyze.R")
source("R/merge_diaster.R")

head(grouped_data)

grouped_data <- grouped_data %>% rename(year = Year)
head(disaster_data_binary)

merged_data <- inner_join(grouped_data, disaster_data_binary, by = c("ISO", "year"))

head(merged_data)

write_csv(merged_data, "final_analytical_data.csv")
