orig_data <- read.csv(file = "data/original-data/Most-Recent-Cohorts-All-Data-Elements.csv")

# demographics predictor
gender_cols <- c("UGDS_MEN", "UGDS_WOMEN")
race_cols <- c("UGDS_WHITE", "UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN")
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
all_cols <- c("UNITID", "INSTNM", "STABBR", demographics_cols, location_cols, comp_pred_cols, comp_measure_cols)

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

# remove rows that has NULL
clean_data <- clean_data[!rowSums(clean_data == "NULL" | clean_data == "PrivacySuppressed" | is.na(clean_data)), ]

write.csv(clean_data, file = "data/cleaned-data/clean-data.csv")

