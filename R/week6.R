finaldata <- read.csv(here("data/analytical", "finaldata.csv"), header = TRUE)

finaldata$log_gdp1000 <- log(finaldata$gdp1000)

plmmod_matmor <- plm(matmor ~ armconf1 + log_gdp1000 + OECD + popdens + urban + 
                agedep + male_edu + temp + rainfall1000 + earthquake + drought,
              index = c("ISO", "year"),
              effect = "twoways",
              model = "within",
              data = finaldata)

plmmod_neomor <- plm(neomor ~ armconf1 + log_gdp1000 + OECD + popdens + urban + 
                agedep + male_edu + temp + rainfall1000 + earthquake + drought,
              index = c("ISO", "year"),
              effect = "twoways",
              model = "within",
              data = finaldata)

plmmod_un5mor <- plm(un5mor ~ armconf1 + log_gdp1000 + OECD + popdens + urban + 
                agedep + male_edu + temp + rainfall1000 + earthquake + drought,
              index = c("ISO", "year"),
              effect = "twoways",
              model = "within",
              data = finaldata)

plmmod_infmor <- plm(infmor ~ armconf1 + log_gdp1000 + OECD + popdens + urban + 
                agedep + male_edu + temp + rainfall1000 + earthquake + drought,
              index = c("ISO", "year"),
              effect = "twoways",
              model = "within",
              data = finaldata)

stargazer(plmmod_matmor, plmmod_neomor, plmmod_un5mor, plmmod_infmor,
          type = "html",  # Change to "latex" for LaTeX output (for PDF conversion)
          title = "Panel Data Models for Mortality Rates",
          column.labels = c("Maternal Mortality", "Neonatal Mortality", 
                            "Under-5 Mortality", "Infant Mortality"),
          covariate.labels = c("Armed Conflict", "Log(GDP per 1000)", "OECD", 
                               "Population Density", "Urbanization", 
                               "Age Dependency", "Male Education", 
                               "Temperature", "Rainfall per 1000", 
                               "Earthquake", "Drought"),
          dep.var.labels.include = FALSE,
          model.names = FALSE,
          star.cutoffs = c(0.1, 0.05, 0.01),  # For significance levels
          out = "table2.html")  # Output as HTML
