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

source(file = "code/functions/regression-functions.R")

### TRAIN ###
set.seed(100)
plsr.fit <- plsr(DIV_SCORE~., data = train_data, validation = "CV")

# save plot
png("images/plsr-diversity-models-plot.png")
validationplot(plsr.fit, val.type = "MSEP")
dev.off()

# model selection
best_comp_num <- which(plsr.fit$validation$PRESS == min(plsr.fit$validation$PRESS))

### TEST ###
target_y <- test_data$DIV_SCORE
# test set prediction -- MSE
plsr.pred <- predict(plsr.fit, test_data[,-ncol(train_data)], ncomp = best_comp_num)
plsr_test_mse <- mean((plsr.pred - target_y)^2)

### FULL DATASET ###
plsr_official_fit <- plsr(DIV_SCORE~., data = full_data, ncomp = best_comp_num)
plsr_official_coef <- coef(plsr_official_fit)

#investigate the models fit
plsr_summary <- data.frame(residual_sum_squares(plsr_official_fit), total_sum_squares(plsr_official_fit), r_squared(plsr_official_fit), residual_std_error(plsr_official_fit), f_statistic(plsr_official_fit))
rownames(plsr_summary) <- "PLSR"
colnames(plsr_summary) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

# save RData
save(plsr.fit, best_comp_num, plsr_test_mse, plsr_official_coef, plsr_summary, file = "data/regressions/plsr-diversity-models.RData")