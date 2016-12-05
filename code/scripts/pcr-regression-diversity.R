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
pcr.fit <- pcr(DIV_SCORE~., data = train_data, validation = "CV")

# save plot
png("images/pcr-diversity-models-plot.png")
validationplot(pcr.fit, val.type = "MSEP")
dev.off()

# model selection
best_comp_num <- which(pcr.fit$validation$PRESS == min(pcr.fit$validation$PRESS))

### TEST ###
target_y <- test_data$DIV_SCORE
# test set prediction -- MSE
pcr.pred <- predict(pcr.fit, test_data[,-ncol(train_data)], ncomp = best_comp_num)
pcr_test_mse <- mean((pcr.pred - target_y)^2)

### FULL DATASET ###
pcr_official_fit <- pcr(DIV_SCORE~., data = full_data, ncomp = best_comp_num)
pcr_official_coef <- coef(pcr_official_fit)

#investigate the models fit
pcr_summary <- data.frame(residual_sum_squares(pcr_official_fit), total_sum_squares(pcr_official_fit), r_squared(pcr_official_fit), residual_std_error(pcr_official_fit), f_statistic(pcr_official_fit))
rownames(pcr_summary) <- "PCR"
colnames(pcr_summary) <- c("RSS", "TSS", "R Squared", "Residual Std. Error", "F Stat")

# save RData
save(pcr.fit, best_comp_num, pcr_test_mse, pcr_official_coef, pcr_summary, file = "data/regressions/pcr-diversity-models.RData")