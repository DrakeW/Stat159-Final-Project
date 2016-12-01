clean_data <- read.csv("data/cleaned-data/clean-data.csv")
clean_data_w_grad_rate <- read.csv("data/cleaned-data/clean-data-w-grad-rate.csv")

# split clean data without graduation rate
row_clean_data <- nrow(clean_data)

set.seed(100)
train_set_indices_1 <- sample(1:row_clean_data, 300)
test_set_indices_1 <- -1 * train_set_indices_1

train_set_1 <- clean_data[train_set_indices_1,][,-1]
test_set_1 <- clean_data[test_set_indices_1,][,-1]

write.csv(train_set_1, file = "data/cleaned-data/train-clean-data.csv")
write.csv(test_set_1, file = "data/cleaned-data/test-clean-data.csv")

# split clean data with graduation rate
row_clean_data_w_grad_rate <- nrow(clean_data_w_grad_rate)

train_set_indices_2 <- sample(1:row_clean_data_w_grad_rate, 80)
test_set_indices_2 <- -1 * train_set_indices_2

train_set_2 <- clean_data_w_grad_rate[train_set_indices_2,][,-1]
test_set_2 <- clean_data_w_grad_rate[test_set_indices_2,][,-1]

write.csv(train_set_2, file = "data/cleaned-data/train-clean-data-w-grad-rate.csv")
write.csv(test_set_2, file = "data/cleaned-data/test-clean-data-w-grad-rate.csv")