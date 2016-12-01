library(glmnet)

# read in data
train_data <- read.csv("data/cleaned-data/train-clean-data.csv")
test_data <- read.csv("data/cleaned-data/test-clean-data.csv")
full_data <- read.csv("data/cleaned-data/clean-data.csv")

train_data <- train_data[,-1]
train_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "GENDER_DIV", "RACE_DIV", "MARITAL_STATUS_DIV", "FIRST_GEN_DIV")] <- NULL

test_data <- test_data[,-1]
test_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "GENDER_DIV", "RACE_DIV", "MARITAL_STATUS_DIV", "FIRST_GEN_DIV")] <- NULL

full_data <- full_data[,-1]
full_data[, c("UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "GENDER_DIV", "RACE_DIV", "MARITAL_STATUS_DIV", "FIRST_GEN_DIV")] <- NULL

### TRAIN ###
train_x <- as.matrix(train_data)
train_y <- train_data$DIV_SCORE
grid <- 10^seq(10, -2, length = 100)
set.seed(100)
ridge.mod <- cv.glmnet(train_x, train_y, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)

# save plot
png("images/ridge-models-diversity-plot.png")
plot(ridge.mod, main = "Ridge Models Diversity Plot")
dev.off()

# model selection
min_lambda <- ridge.mod$lambda.min
best_fit <- glmnet(train_x, train_y, intercept = FALSE, standardize = FALSE, lambda = min_lambda, alpha = 0)

### TEST ###
test_x <- as.matrix(test_data)
target_y <- test_data$DIV_SCORE
# test set prediction -- MSE
ridge.pred <- predict(best_fit, newx = test_x)
ridge_test_mse <- mean((ridge.pred - target_y)^2)

### FULL DATASET ###
full_x <- as.matrix(full_data)
full_y <- full_data$DIV_SCORE

official_fit <- glmnet(full_x, full_y, intercept = FALSE, standardize = FALSE, lambda = min_lambda, alpha = 0)
ridge_official_coef <- coef(official_fit)

# save RData
save(ridge.mod, min_lambda, ridge_test_mse, ridge_official_coef, file = "data/regressions/ridge-diversity-models.RData")
