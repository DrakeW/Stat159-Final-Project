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
pcr.fit.grad <- pcr(C100_4~., data = train_data, validation = "CV")

# save plot
png("images/pcr-grad-rate-models-plot.png")
validationplot(pcr.fit.grad, val.type = "MSEP")
dev.off()

# model selection
best_comp_num <- which(pcr.fit.grad$validation$PRESS == min(pcr.fit.grad$validation$PRESS))

### TEST ###
target_y <- test_data$C100_4
# test set prediction -- MSE
pcr.pred <- predict(pcr.fit.grad, test_data[,-19], ncomp = best_comp_num)
pcr_test_mse.grad <- mean((pcr.pred - target_y)^2)

### FULL DATASET ###
pcr_official_fit <- pcr(C100_4~., data = full_data, ncomp = best_comp_num)
pcr_official_coef.grad <- coef(pcr_official_fit)

#investigate the models fit
pcr_summary.grad <- data.frame(residual_sum_squares(pcr_official_fit), total_sum_squares(pcr_official_fit), r_squared(pcr_official_fit), residual_std_error(pcr_official_fit), f_statistic(pcr_official_fit))
rownames(pcr_summary.grad) <- "PCR"
colnames(pcr_summary.grad) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

# save RData
save(pcr.fit.grad, best_comp_num, pcr_test_mse.grad, pcr_official_coef.grad, pcr_summary.grad, file = "data/regressions/pcr-grad-rate-models.RData")
