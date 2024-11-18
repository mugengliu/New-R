library("here")
library("plm")
library("dplyr")
library("mice")
library("modelsummary")

finaldata <- read.csv(here("data/analytical", "finaldata.csv"), header = TRUE)

finaldata$loggdp <- log(finaldata$gdp1000)

preds <- as.formula(" ~ armconf1 + loggdp + OECD + popdens + urban + 
                  agedep + male_edu + temp + rainfall1000 + earthquake + drought")

matmormod <- plm(update.formula(preds, matmor ~ .), index = c("ISO", "year"), effect = "twoways",
                 model = "within", data = finaldata)
un5mormod <- plm(update.formula(preds, un5mor ~ .), index = c("ISO", "year"), effect = "twoways",
                 model = "within", data = finaldata)
infmormod <- plm(update.formula(preds, infmor ~ .), index = c("ISO", "year"), effect = "twoways",
                 model = "within", data = finaldata)
neomormod <- plm(update.formula(preds, neomor ~ .), index = c("ISO", "year"), effect = "twoways",
                 model = "within", data = finaldata)

midata <- finaldata |>
  mutate(ISOnum = as.numeric(as.factor(finaldata$ISO))) |>
  select(-country_name, -ISO)

mice0  <- mice(midata, seed = 100, m = 5, maxit = 0, print = F)
meth <- mice0$method
meth[c("urban", "male_edu", "temp", "rainfall1000", "matmor", "infmor", "neomor", "un5mor", "loggdp", "popdens")] <- "2l.lmer"
pred <- mice0$predictorMatrix
pred[c("urban", "male_edu", "temp", "rainfall1000", "matmor", "infmor", "neomor", "un5mor", "loggdp", "popdens"), "ISOnum"] <- -2
mice.multi.out  <- mice(midata, seed = 100, m = 10, maxit = 20,
                        method = meth,
                        predictorMatrix = pred)

plot(mice.multi.out)

complete.data <- complete(mice.multi.out, "all")
head(complete.data$`1`)

fit_matmor <- with(mice.multi.out, lm(matmor ~ armconf1 + loggdp + OECD + popdens + urban + agedep + male_edu + temp + rainfall1000 + earthquake + drought))
fit_un5mor <- with(mice.multi.out, lm(un5mor ~ armconf1 + loggdp + OECD + popdens + urban + agedep + male_edu + temp + rainfall1000 + earthquake + drought))
fit_infmor <- with(mice.multi.out, lm(infmor ~ armconf1 + loggdp + OECD + popdens + urban + agedep + male_edu + temp + rainfall1000 + earthquake + drought))
fit_neomor <- with(mice.multi.out, lm(neomor ~ armconf1 + loggdp + OECD + popdens + urban + agedep + male_edu + temp + rainfall1000 + earthquake + drought))
summary(pool(fit_matmor))
summary(pool(fit_un5mor))
summary(pool(fit_infmor))
summary(pool(fit_neomor))


#Final Table here follow the slide on week6
model_list <- list(
  "Complete Case - Matmor" = matmormod,
  "MI - Matmor" = pool(fit_matmor),
  "Complete Case - Un5mor" = un5mormod,
  "MI - Un5mor" = pool(fit_un5mor),
  "Complete Case - Infmor" = infmormod,
  "MI - Infmor" = pool(fit_infmor),
  "Complete Case - Neomor" = neomormod,
  "MI - Neomor" = pool(fit_neomor)
)


modelsummary(model_list, statistic = "conf.int", stars = TRUE)
