library(pls)

# read in data
train_data <- read.csv("data/cleaned-data/train-clean-data-w-grad-rate.csv")
test_data <- read.csv("data/cleaned-data/test-clean-data-w-grad-rate.csv")
full_data <- read.csv("data/cleaned-data/clean-data-w-grad-rate.csv")

train_data <- train_data[,-1]
train_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP")] <- NULL

test_data <- test_data[,-1]
test_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP")] <- NULL

full_data <- full_data[,-1]
full_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP")] <- NULL

source(file = "code/functions/regression-functions.R")

### TRAIN ###
set.seed(100)
plsr.fit <- plsr(C100_4~., data = train_data, validation = "CV")

# save plot
png("images/plsr-grad-rate-models-plot.png")
validationplot(plsr.fit, val.type = "MSEP")
dev.off()

# model selection
best_comp_num <- which(plsr.fit$validation$PRESS == min(plsr.fit$validation$PRESS))

### TEST ###
target_y <- test_data$C100_4
# test set prediction -- MSE
plsr.pred <- predict(plsr.fit, test_data[,-19], ncomp = best_comp_num)
plsr_test_mse <- mean((plsr.pred - target_y)^2)

### FULL DATASET ###
plsr_official_fit <- plsr(C100_4~., data = full_data, ncomp = best_comp_num)
plsr_official_coef <- coef(plsr_official_fit)

#investigate the models fit
plsr_summary <- data.frame(residual_sum_squares(plsr_official_fit), total_sum_squares(plsr_official_fit), r_squared(plsr_official_fit), residual_std_error(plsr_official_fit), f_statistic(plsr_official_fit))
rownames(plsr_summary) <- "PLSR"
colnames(plsr_summary) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

# save RData
save(plsr.fit, best_comp_num, plsr_test_mse, plsr_official_coef, plsr_summary, file = "data/regressions/plsr-grad-rate-models.RData")
