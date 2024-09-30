matmor <- read.csv(here("data", "original", "maternalmortality.csv"), header = TRUE)
matmor <- matmor |>
  dplyr::select(Country.Name, X2000:X2019) |>
  pivot_longer(cols = starts_with("X"),
               names_to = "year",
               names_prefix = "X",
               values_to = "MatMor") |>
  mutate(year = as.numeric(year))
head(matmor, 20)
tail(matmor, 20)
