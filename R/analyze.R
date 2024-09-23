library(readr)
library(dplyr)

maternal_mortality_data <- read_csv("original/disaster.csv")

filtered_data <- maternal_mortality_data %>%
  filter(Year >= 2000 & Year <= 2019, `Disaster Type` %in% c("Earthquake", "Drought")) %>% select(Year, ISO, `Disaster Type`) %>%
  mutate(
    drought = ifelse(`Disaster Type` == "Drought", 1, 0),
    earthquake = ifelse(`Disaster Type` == "Earthquake", 1, 0)
  )

# View the filtered data
head(filtered_data)

grouped_data <- filtered_data %>%
  group_by(Year, ISO) %>%
  summarize(
    drought = max(drought),
    earthquake = max(earthquake)
  )


