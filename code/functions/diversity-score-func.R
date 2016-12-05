ca_diversity_ratio_data <- read.csv(file = "data/expected_proportion.csv")
gender_cols <- c("UGDS_MEN", "UGDS_WOMEN")
race_cols <- c("UGDS_WHITE", "UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR")
#expected_gender_ratio <- ca_diversity_ratio_data[1, gender_cols]
#expected_race_ratio <- ca_diversity_ratio_data[1, race_cols]

data <- read.csv(file = "data/cleaned-data/clean-data.csv")
expected_gender_ratio <- c(mean(data$UGDS_MEN), mean(data$UGDS_WOMEN))
expected_race_ratio <- c()
for (col in race_cols) {
  expected_race_ratio <- c(expected_race_ratio, mean(data[[col]]))
}

get_gender_diversity_score <- function(school) {
  gender_ratio <- c(school[["UGDS_MEN"]], school[["UGDS_WOMEN"]])
  1 - sum(chi_squere(as.numeric(gender_ratio), expected_gender_ratio))
}

get_racial_diversity_score <- function(school) {
  race_ratio <- c()
  for (col in race_cols) {
    race_ratio <- c(race_ratio, school[[col]])
  }
  1 - sum(chi_squere(as.numeric(race_ratio), expected_race_ratio))
}

get_first_generation_diversity_score <- function(data) {
  expected <- mean(data$FIRST_GEN)
  1 - chi_squere(data[["FIRST_GEN"]], expected)
}

get_marital_status_diversity_score <- function(data) {
  expected <- mean(data$MARRIED)
  1 - chi_squere(data[["MARRIED"]], expected)
}

chi_squere <- function(real, expected) {
  (real - expected)^2 / expected
}
