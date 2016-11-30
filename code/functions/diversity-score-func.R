ca_diversity_ratio_data <- read.csv()
expected_gender_ratio <- ca_diversity_ratio_data[1, ]
expected_race_ratio <- 

get_gender_diversity_score <- function(school) {
  gender_ratio <- c(school$UGDS_MEN, school$UGDS_WOMEN)
  1 - sum(chi_squere(gender_ratio, expected_gender_ratio))
}

get_racial_diversity_score <- function() {
  
}

get_first_generation_diversity_score <- function() {
  
}

get_marital_status_diversity_score <- function() {
  
}

chi_squere <- function(real, expected) {
  (real - expected)^2 / expected
}