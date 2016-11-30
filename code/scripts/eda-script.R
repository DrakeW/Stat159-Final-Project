college_data <- read.csv("data/clean-data.csv")

#Quantitative Variables 

##MEN 

men_stats <- c(median(college_data$UGDS_MEN), quantile(college_data$UGDS_MEN)[2], quantile(college_data$UGDS_MEN)[4],IQR(college_data$UGDS_MEN),mean(college_data$UGDS_MEN),sd(college_data$UGDS_MEN))
names(men_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
men_stats <- as.data.frame(men_stats)
colnames(men_stats) <- "MEN"

##WOMEN

women_stats <- c(median(college_data$UGDS_WOMEN), quantile(college_data$UGDS_WOMEN)[2], quantile(college_data$UGDS_WOMEN)[4],IQR(college_data$UGDS_WOMEN),mean(college_data$UGDS_WOMEN),sd(college_data$UGDS_WOMEN))
names(women_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
women_stats <- as.data.frame(women_stats)
colnames(women_stats) <- "WOMEN"

##WHITE

white_stats <- c(median(college_data$UGDS_WHITE), quantile(college_data$UGDS_WHITE)[2], quantile(college_data$UGDS_WHITE)[4],IQR(college_data$UGDS_WHITE),mean(college_data$UGDS_WHITE),sd(college_data$UGDS_WHITE))
names(white_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
white_stats <- as.data.frame(white_stats)
colnames(white_stats) <- "WHITE"

##BLACK

black_stats <- c(median(college_data$UGDS_BLACK), quantile(college_data$UGDS_BLACK)[2], quantile(college_data$UGDS_BLACK)[4],IQR(college_data$UGDS_BLACK),mean(college_data$UGDS_BLACK),sd(college_data$UGDS_BLACK))
names(black_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
black_stats <- as.data.frame(black_stats)
colnames(black_stats) <- "BLACK"

##HISP

hisp_stats <- c(median(college_data$UGDS_HISP), quantile(college_data$UGDS_HISP)[2], quantile(college_data$UGDS_HISP)[4],IQR(college_data$UGDS_HISP),mean(college_data$UGDS_HISP),sd(college_data$UGDS_HISP))
names(hisp_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
hisp_stats <- as.data.frame(hisp_stats)
colnames(hisp_stats) <- "HISPANIC"

##ASIAN

asian_stats <- c(median(college_data$UGDS_ASIAN), quantile(college_data$UGDS_ASIAN)[2], quantile(college_data$UGDS_ASIAN)[4],IQR(college_data$UGDS_ASIAN),mean(college_data$UGDS_ASIAN),sd(college_data$UGDS_ASIAN))
names(asian_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
asian_stats <- as.data.frame(asian_stats)
colnames(asian_stats) <- "ASIAN"


##AIAN

aian_stats <- c(median(college_data$UGDS_AIAN), quantile(college_data$UGDS_AIAN)[2], quantile(college_data$UGDS_AIAN)[4],IQR(college_data$UGDS_AIAN),mean(college_data$UGDS_AIAN),sd(college_data$UGDS_AIAN))
names(aian_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
aian_stats <- as.data.frame(aian_stats)
colnames(aian_stats) <- "AMERICAN INDIAN"

##FIRST_GEN 

first_gen_stats <- c(median(college_data$FIRST_GEN), quantile(college_data$FIRST_GEN)[2], quantile(college_data$FIRST_GEN)[4],IQR(college_data$FIRST_GEN),mean(college_data$FIRST_GEN),sd(college_data$FIRST_GEN))
names(first_gen_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
first_gen_stats <- as.data.frame(first_gen_stats)
colnames(first_gen_stats) <- "FIRST GEN"

##NOT_FIRST_GEN

not_first_gen_stats <- (1 - first_gen_stats)
colnames(not_first_gen_stats) <- "NOT FIRST GEN"

##MARRIED

married_stats <- c(median(college_data$MARRIED), quantile(college_data$MARRIED)[2], quantile(college_data$MARRIED)[4],IQR(college_data$MARRIED),mean(college_data$MARRIED),sd(college_data$MARRIED))
names(married_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
married_stats <- as.data.frame(married_stats)
colnames(married_stats) <- "MARRIED"

##SINGLE 

single_stats <- (1 - married_stats)
colnames(single_stats) <- "SINGLE"

##PCTFLOAN

pctfloan_stats <- c(median(college_data$PCTFLOAN), quantile(college_data$PCTFLOAN)[2], quantile(college_data$PCTFLOAN)[4],IQR(college_data$PCTFLOAN),mean(college_data$PCTFLOAN),sd(college_data$PCTFLOAN))
names(pctfloan_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
pctfloan_stats <- as.data.frame(pctfloan_stats)
colnames(pctfloan_stats) <- "PCT FEDERAL LOAN"

##DEBT_MDN

debt_mdn_stats <- c(median(college_data$DEBT_MDN), quantile(college_data$DEBT_MDN)[2], quantile(college_data$DEBT_MDN)[4],IQR(college_data$DEBT_MDN),mean(college_data$DEBT_MDN),sd(college_data$DEBT_MDN))
names(debt_mdn_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
debt_mdn_stats <- as.data.frame(debt_mdn_stats)
colnames(debt_mdn_stats) <- "MEDIAN DEBT"

##MN_EARN_WNE_P10

mn_earn_stats <- c(median(college_data$MN_EARN_WNE_P10), quantile(college_data$MN_EARN_WNE_P10)[2], quantile(college_data$MN_EARN_WNE_P10)[4],IQR(college_data$MN_EARN_WNE_P10),mean(college_data$MN_EARN_WNE_P10),sd(college_data$MN_EARN_WNE_P10))
names(mn_earn_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
mn_earn_stats <- as.data.frame(mn_earn_stats)
colnames(mn_earn_stats) <- "MEAN EARNINGS"

