library(readr)
library(dplyr)

data <- read_csv("data/analytical/finaldata.csv")

data_2017 <- filter(data, year == "2017")

# first quiz answer
sum(is.na(data_2017$matmor))


data_no <- filter(data_2017, !is.na(matmor))

# second quiz answer
sum(data_no$armconf1 == 1, na.rm = TRUE)
sum(data_no$armconf1 == 0, na.rm = TRUE)


data_conf <- filter(data_no, armconf1 == 1)

# third quiz answer
mat_med <- median(data_conf$matmor, na.rm = TRUE)
mat_med

library(boot)

getmeddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$matmor, sample_data$armconf1, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

bootout <- boot(data, statistic = getmeddiff, strata = data$armconf1, R = 1000)
bootout
