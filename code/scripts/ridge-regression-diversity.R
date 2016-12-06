library(pls)

# read in data
train_data <- read.csv("data/cleaned-data/train-clean-data.csv")
test_data <- read.csv("data/cleaned-data/test-clean-data.csv")
full_data <- read.csv("data/cleaned-data/clean-data.csv")

gender_cols <- c("UGDS_MEN", "UGDS_WOMEN")
race_cols <- c("UGDS_WHITE", "UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR")
generation_cols <- c("FIRST_GEN")
marital_status_cols <- c("MARRIED")

directly_related_cols <- c(gender_cols,race_cols,generation_cols,marital_status_cols, "UNITID", "INSTNM", "STABBR", "CITY", "ZIP", "GENDER_DIV", "RACE_DIV", "MARITAL_STATUS_DIV", "FIRST_GEN_DIV")


train_data <- train_data[,-1]
train_data[, directly_related_cols] <- NULL

test_data <- test_data[,-1]
test_data[, directly_related_cols] <- NULL

full_data <- full_data[,-1]
full_data[, directly_related_cols] <- NULL

### TRAIN ###
train_x <- as.matrix(train_data[,-ncol(train_data)])
train_y <- train_data$DIV_SCORE
grid <- 10^seq(10, -2, length = 100)
set.seed(100)
ridge.mod <- cv.glmnet(train_x, train_y, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)

# save plot
png("images/ridge-diversity-models-plot.png")
plot(ridge.mod, main = "Ridge Models Diversity Plot")
dev.off()

# model selection
min_lambda <- ridge.mod$lambda.min
best_fit <- glmnet(train_x, train_y, intercept = FALSE, standardize = FALSE, lambda = min_lambda, alpha = 0)

### TEST ###
test_x <- as.matrix(test_data[,-ncol(train_data)])
target_y <- as.matrix(test_data$DIV_SCORE)
# test set prediction -- MSE
ridge.pred <- predict(best_fit, newx = test_x)
ridge_test_mse <- mean((ridge.pred - target_y)^2)

### FULL DATASET ###
full_x <- as.matrix(full_data[,-ncol(train_data)])
full_y <- full_data$DIV_SCORE

official_fit <- glmnet(full_x, full_y, intercept = FALSE, standardize = FALSE, lambda = min_lambda, alpha = 0)
ridge_official_coef <- coef(official_fit)

# save RData
save(ridge.mod, min_lambda, ridge_test_mse, ridge_official_coef, file = "data/regressions/ridge-diversity-models.RData")
