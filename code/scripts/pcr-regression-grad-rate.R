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
pcr.fit <- pcr(C100_4~., data = train_data, validation = "CV")

# save plot
png("images/pcr-grad-rate-models-plot.png")
validationplot(pcr.fit, val.type = "MSEP")
dev.off()

# model selection
best_comp_num <- which(pcr.fit$validation$PRESS == min(pcr.fit$validation$PRESS))

### TEST ###
target_y <- test_data$C100_4
# test set prediction -- MSE
pcr.pred <- predict(pcr.fit, test_data[,-19], ncomp = best_comp_num)
pcr_test_mse <- mean((pcr.pred - target_y)^2)

### FULL DATASET ###
pcr_official_fit <- pcr(C100_4~., data = full_data, ncomp = best_comp_num)
pcr_official_coef <- coef(pcr_official_fit)

#investigate the models fit
pcr_summary <- data.frame(residual_sum_squares(pcr_official_fit), total_sum_squares(pcr_official_fit), r_squared(pcr_official_fit), residual_std_error(pcr_official_fit), f_statistic(pcr_official_fit))
rownames(pcr_summary) <- "PCR"
colnames(pcr_summary) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

# save RData
save(pcr.fit, best_comp_num, pcr_test_mse, pcr_official_coef, pcr_summary, file = "data/regressions/pcr-grad-rate-models.RData")
