# read in data
data <- read.csv(file = "data/cleaned-data/clean-data-w-grad-rate.csv")

source(file = "code/functions/regression-functions.R")

data <- data[,-1]
data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "UGDS_WOMEN", "ICL")] <- NULL

# fit model with data
ols.mod.grad <- lm(C100_4~., data = data)
ols.coef.grad <- coef(ols.mod.grad)

#investigate the models fit 
ols_summary.grad <- data.frame(residual_sum_squares(ols.mod.grad), total_sum_squares(ols.mod.grad), r_squared(ols.mod.grad), residual_std_error(ols.mod.grad), f_statistic(ols.mod.grad))
rownames(ols_summary.grad) <- "OLS"
colnames(ols_summary.grad) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

save(ols.mod.grad, ols.coef.grad, ols_summary.grad, file = "data/regressions/ols-grad-rate-model.RData")
