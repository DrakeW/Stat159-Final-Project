orig_data <- read.csv(file = "data/original-data/Most-Recent-Cohorts-All-Data-Elements.csv")

# demographics predictor
gender_cols <- c("UGDS_MEN", "UGDS_WOMEN")
race_cols <- c("UGDS_WHITE", "UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR")
generation_cols <- c("FIRST_GEN")
marital_status_cols <- c("MARRIED")

demographics_cols <- c(gender_cols, race_cols, generation_cols, marital_status_cols)

# population center predictor
location_cols <- c("CITY", "ZIP")

# potential competitiveness predictor
inst_body_cols <- c("CONTROL", "PCTFLOAN", "ADM_RATE_ALL", "HIGHDEG", "PREDDEG", "ICLEVEL")
sat_act_scores <- c("SATVRMID", "SATMTMID", "SATWRMID", "ACTENMID", "ACTMTMID", "ACTWRMID")
edu_cost_cols <- c("DEBT_MDN")

comp_pred_cols <- c(inst_body_cols, sat_act_scores, edu_cost_cols)

# competitiveness measurement
completion_cols <- c("C100_4")
earnings_cols <- c("MN_EARN_WNE_P10")

comp_measure_cols <- c(completion_cols, earnings_cols)

# aggregate all selected columns
all_cols <- c("LATITUDE", "LONGITUDE", "UNITID", "INSTNM", "STABBR", demographics_cols, location_cols, comp_pred_cols, comp_measure_cols)

raw_data <- orig_data[, all_cols]

raw_data <- raw_data[raw_data$STABBR == "CA", ]

# remove cols that has more than 75% NULLs
num_nulls_in_col <- colSums(raw_data == "NULL" | is.na(raw_data))
num_rows <- nrow(raw_data)
selected_cols <- c()
for (i in seq(num_nulls_in_col)) {
  if (num_nulls_in_col[i] / num_rows < 0.75) {
    selected_cols <- c(selected_cols, i)
  }
}

clean_data <- raw_data[, selected_cols]
# diff data set with grad rate
clean_data_w_grad_rate <- clean_data
clean_data_w_grad_rate$C100_4 <- raw_data$C100_4

# remove rows that has NULL
clean_data <- clean_data[!rowSums(clean_data == "NULL" | clean_data == "PrivacySuppressed" | is.na(clean_data)), ]
clean_data_w_grad_rate <- clean_data_w_grad_rate[!rowSums(clean_data_w_grad_rate == "NULL" | clean_data_w_grad_rate == "PrivacySuppressed" | is.na(clean_data_w_grad_rate)), ]

# convert column type

col_type_convert <- function(clean_data) {
  inst_name <- clean_data$INSTNM
  stateabbr_name <- clean_data$STABBR
  city_name <- clean_data$CITY
  zip_name <- clean_data$ZIP
  
  indx <- sapply(clean_data, is.factor)
  clean_data[indx] <- lapply(clean_data[indx], function(x) as.numeric(as.character(x)))
  
  indx <- sapply(clean_data, is.character)
  clean_data[indx] <- lapply(clean_data[indx], function(x) as.numeric(x))
  
  clean_data$INSTNM = inst_name
  clean_data$STABBR = stateabbr_name
  clean_data$CITY = city_name
  clean_data$ZIP = zip_name
  
  clean_data
}

clean_data <- col_type_convert(clean_data)
clean_data_w_grad_rate <- col_type_convert(clean_data_w_grad_rate)

# add diversity score column
source("code/functions/diversity-score-func.R")

clean_data$GENDER_DIV <- apply(clean_data, 1, get_gender_diversity_score)
clean_data$RACE_DIV <- apply(clean_data, 1, get_racial_diversity_score)
clean_data$MARITAL_STATUS_DIV <- get_marital_status_diversity_score(clean_data)
clean_data$FIRST_GEN_DIV <- get_first_generation_diversity_score(clean_data)

clean_data$DIV_SCORE <- apply(clean_data[c("GENDER_DIV", "RACE_DIV", "MARITAL_STATUS_DIV", "FIRST_GEN_DIV")], 1, mean)

# write to clean data file
write.csv(clean_data, file = "data/cleaned-data/clean-data-w-geo.csv")

clean_data$LATITUDE <- NULL
clean_data$LONGITUDE <- NULL
clean_data_w_grad_rate$LATITUDE <- NULL
clean_data_w_grad_rate$LONGITUDE <- NULL

write.csv(clean_data, file = "data/cleaned-data/clean-data.csv")
write.csv(clean_data_w_grad_rate, file = "data/cleaned-data/clean-data-w-grad-rate.csv")
