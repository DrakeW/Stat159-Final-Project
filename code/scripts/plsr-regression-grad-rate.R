library(pls)

# read in data
train_data <- read.csv("data/cleaned-data/train-clean-data-w-grad-rate.csv")
test_data <- read.csv("data/cleaned-data/test-clean-data-w-grad-rate.csv")
full_data <- read.csv("data/cleaned-data/clean-data-w-grad-rate.csv")

train_data <- train_data[,-1]
train_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "UGDS_WOMEN", "ICLEVEL")] <- NULL

test_data <- test_data[,-1]
test_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "UGDS_WOMEN", "ICLEVEL")] <- NULL

full_data <- full_data[,-1]
full_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "UGDS_WOMEN", "ICLEVEL")] <- NULL

source(file = "code/functions/regression-functions.R")

### TRAIN ###
set.seed(100)
plsr.fit.grad <- plsr(C100_4~., data = train_data, validation = "CV")

# save plot
png("images/plsr-grad-rate-models-plot.png")
validationplot(plsr.fit.grad, val.type = "MSEP")
dev.off()

# model selection
best_comp_num <- which(plsr.fit.grad$validation$PRESS == min(plsr.fit.grad$validation$PRESS))

### TEST ###
target_y <- test_data$C100_4
# test set prediction -- MSE
plsr.pred <- predict(plsr.fit.grad, test_data[,-19], ncomp = best_comp_num)
plsr_test_mse.grad <- mean((plsr.pred - target_y)^2)

### FULL DATASET ###
plsr_official_fit <- plsr(C100_4~., data = full_data, ncomp = best_comp_num)
plsr_official_coef.grad <- coef(plsr_official_fit)

#investigate the models fit
plsr_summary.grad <- data.frame(residual_sum_squares(plsr_official_fit), total_sum_squares(plsr_official_fit), r_squared(plsr_official_fit), residual_std_error(plsr_official_fit), f_statistic(plsr_official_fit))
rownames(plsr_summary.grad) <- "PLSR"
colnames(plsr_summary.grad) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

# save RData
save(plsr.fit.grad, best_comp_num, plsr_test_mse.grad, plsr_official_coef.grad, plsr_summary.grad, file = "data/regressions/plsr-grad-rate-models.RData")
