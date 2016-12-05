library(glmnet)

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

### TRAIN ###
train_x <- as.matrix(train_data[,-17])
train_y <- train_data$C100_4
grid <- 10^seq(10, -2, length = 100)
set.seed(100)
lasso.mod.grad <- cv.glmnet(train_x, train_y, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 1)

# save plot
png("images/lasso-grad-rate-models-plot.png")
plot(lasso.mod.grad)
title("Lasso Models Graduation Rates Plot", line=2.5)
dev.off()

# model selection
min_lambda <- lasso.mod.grad$lambda.min
best_fit <- glmnet(train_x, train_y, intercept = FALSE, standardize = FALSE, lambda = min_lambda, alpha = 1)

### TEST ###
test_x <- as.matrix(test_data[,-17])
target_y <- test_data$C100_4
# test set prediction -- MSE
lasso.pred <- predict(best_fit, newx = test_x)
lasso_test_mse.grad <- mean((lasso.pred - target_y)^2)

### FULL DATASET ###
full_x <- as.matrix(full_data[,-17])
full_y <- full_data$C100_4

official_fit <- glmnet(full_x, full_y, intercept = FALSE, standardize = FALSE, lambda = min_lambda, alpha = 1)
lasso_official_coef.grad <- coef(official_fit)

# save RData
save(lasso.mod.grad, min_lambda, lasso_test_mse.grad, lasso_official_coef.grad, file = "data/regressions/lasso-grad-rate-models.RData")
