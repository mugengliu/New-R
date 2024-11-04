finaldata <- read.csv(here("data/analytical", "finaldata.csv"), header = TRUE)

finaldata$log_gdp1000 <- log(finaldata$gdp1000)

preds <- as.formula(" ~ armconf1 + loggdp + OECD + pctpopdens + urban + 
                  agedep + male_edu + temp + rainfall1000 + earthquake + drought")

matmormod <- plm(update.formula(preds, matmor ~ .), index = c("ISO", "year"), effect = "twoways",
                 model = "within", data = finaldata)
un5mormod <- plm(update.formula(preds, un5mor ~ .), index = c("ISO", "year"), effect = "twoways",
                 model = "within", data = finaldata)
infmormod <- plm(update.formula(preds, infmor ~ .), index = c("ISO", "year"), effect = "twoways",
                 model = "within", data = finaldata)
neomormod <- plm(update.formula(preds, neomor ~ .), index = c("ISO", "year"), effect = "twoways",
                 model = "within", data = finaldata)