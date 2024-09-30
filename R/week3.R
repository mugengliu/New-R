finaldata <- read.csv(here("data/analytical", "finaldata.csv"), header = TRUE)
names(finaldata)

finaldata %>%
  dplyr::filter(country_name == "Canada")
finaldata %>%
  dplyr::filter(country_name == "Ecuador")

finaldata |>
  summary()

rows_u <- finaldata[is.na(finaldata$matmor), c("country_name", "year")]

length(unique(rows_u$country_name))

length(unique(finaldata$year))
