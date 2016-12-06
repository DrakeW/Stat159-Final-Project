# read in data
data <- read.csv(file = "data/cleaned-data/clean-data.csv")

source(file = "code/functions/regression-functions.R")

gender_cols <- c("UGDS_MEN", "UGDS_WOMEN")
race_cols <- c("UGDS_WHITE", "UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR")
generation_cols <- c("FIRST_GEN")
marital_status_cols <- c("MARRIED")

directly_related_cols <- c(gender_cols,race_cols,generation_cols,marital_status_cols, "UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "GENDER_DIV", "RACE_DIV", "MARITAL_STATUS_DIV", "FIRST_GEN_DIV")

data <- data[,-1]
data[, directly_related_cols] <- NULL

# fit model with data
ols.mod <- lm(DIV_SCORE~., data = data)
ols.coef <- coef(ols.mod)

#investigate the models fit 
ols_summary <- data.frame(residual_sum_squares(ols.mod), total_sum_squares(ols.mod), r_squared(ols.mod), residual_std_error(ols.mod), f_statistic(ols.mod))
rownames(ols_summary) <- "OLS"
colnames(ols_summary) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

save(ols.mod, ols.coef, ols_summary, file = "data/regressions/ols-diversity-model.RData")
