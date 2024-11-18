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
