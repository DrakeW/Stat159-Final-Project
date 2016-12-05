# read in data
data <- read.csv(file = "data/cleaned-data/clean-data.csv")

source(file = "code/functions/regression-functions.R")

data <- data[,-1]
data[, c("UNITID", "UGDS_WOMEN", "INSTNM", "STABBR", "CITY", "ZIP", "GENDER_DIV", "RACE_DIV", "MARITAL_STATUS_DIV", "FIRST_GEN_DIV")] <- NULL

# fit model with data
ols.mod <- lm(DIV_SCORE~., data = data)
ols.coef <- coef(ols.mod)

#investigate the models fit 
ols_summary <- data.frame(residual_sum_squares(ols.mod), total_sum_squares(ols.mod), r_squared(ols.mod), residual_std_error(ols.mod), f_statistic(ols.mod))
rownames(ols_summary) <- "OLS"
colnames(ols_summary) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

save(ols.mod, ols.coef, ols_summary, file = "data/regressions/ols-diversity-model.RData")
