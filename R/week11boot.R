library(readr)
library(dplyr)
library(boot)

data <- read_csv("data/analytical/finaldata.csv")


getmeddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$matmor, sample_data$armconf1, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

bootout <- boot(data, statistic = getmeddiff, strata = data$armconf1, R = 1000)
bootout