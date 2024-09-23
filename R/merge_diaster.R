library(readr)
library(dplyr)
disaster_data <- read_csv("original/conflictdata.csv")

disaster_data_binary <- disaster_data %>%
  group_by(ISO, year) %>% 
  summarise(conflict = ifelse(any(best > 0), 1, 0)) %>% 
  ungroup()

disaster_data_binary <- disaster_data_binary %>%
  arrange(ISO, year) %>% 
  group_by(ISO) %>%
  mutate(lagged_conflict = lag(conflict, 1, default = 0)) %>% 
  ungroup()

head(disaster_data_binary)