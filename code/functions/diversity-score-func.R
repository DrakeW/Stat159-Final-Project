ca_diversity_ratio_data <- read.csv(file = "data/expected_proportion.csv")
expected_gender_ratio <- ca_diversity_ratio_data[1, c("UGDS_MEN", "UGDS_WOMEN")]
expected_race_ratio <- ca_diversity_ratio_data[1, c("UGDS_WHITE", "UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR")]

get_gender_diversity_score <- function(school) {
  gender_ratio <- school[,c("UGDS_MEN", "UGDS_WOMEN")]
  1 - sum(chi_squere(gender_ratio, expected_gender_ratio))
}

get_racial_diversity_score <- function(school) {
  race_ratio <- school[, c("UGDS_WHITE", "UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR")]
  1 - sum(chi_squere(race_ratio, expected_race_ratio))
}

get_first_generation_diversity_score <- function(data) {
  expected <- mean(data$FIRST_GEN)
  1 - chi_squere(data$FIRST_GEN, expected)
}

get_marital_status_diversity_score <- function(data) {
  expected <- mean(data$MARRIED)
  1 - chi_squere(data$MARRIED, expected)
}

chi_squere <- function(real, expected) {
  (real - expected)^2 / expected
}