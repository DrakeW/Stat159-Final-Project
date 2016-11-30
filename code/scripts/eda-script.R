college_data <- read.csv("data/clean-data.csv")

#Quantitative Variables 

##UGDS_MEN 

ugds_men_stats <- c(median(college_data$UGDS_MEN), quantile(college_data$UGDS_MEN)[2], quantile(college_data$UGDS_MEN)[4],IQR(college_data$UGDS_MEN),mean(college_data$UGDS_MEN),sd(college_data$UGDS_MEN))
names(ugds_men_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
ugds_men_stats <- as.data.frame(ugds_men_stats)
colnames(ugds_men_stats) <- "UGDS_MEN"

##UGDS_WOMEN

ugds_women_stats <- c(median(college_data$UGDS_WOMEN), quantile(college_data$UGDS_WOMEN)[2], quantile(college_data$UGDS_WOMEN)[4],IQR(college_data$UGDS_WOMEN),mean(college_data$UGDS_WOMEN),sd(college_data$UGDS_WOMEN))
names(ugds_women_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
ugds_women_stats <- as.data.frame(ugds_women_stats)
colnames(ugds_women_stats) <- "UGDS_WOMEN"

##UGDS_WHITE

ugds_white_stats <- c(median(college_data$UGDS_WHITE), quantile(college_data$UGDS_WHITE)[2], quantile(college_data$UGDS_WHITE)[4],IQR(college_data$UGDS_WHITE),mean(college_data$UGDS_WHITE),sd(college_data$UGDS_WHITE))
names(ugds_white_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
ugds_white_stats <- as.data.frame(ugds_white_stats)
colnames(ugds_white_stats) <- "UGDS_WHITE"

##UGDS_BLACK

ugds_black_stats <- c(median(college_data$UGDS_BLACK), quantile(college_data$UGDS_BLACK)[2], quantile(college_data$UGDS_BLACK)[4],IQR(college_data$UGDS_BLACK),mean(college_data$UGDS_BLACK),sd(college_data$UGDS_BLACK))
names(ugds_black_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
ugds_black_stats <- as.data.frame(ugds_black_stats)
colnames(ugds_black_stats) <- "UGDS_BLACK"

##UGDS_HISP

ugds_hisp_stats <- c(median(college_data$UGDS_HISP), quantile(college_data$UGDS_HISP)[2], quantile(college_data$UGDS_HISP)[4],IQR(college_data$UGDS_HISP),mean(college_data$UGDS_HISP),sd(college_data$UGDS_HISP))
names(ugds_hisp_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
ugds_hisp_stats <- as.data.frame(ugds_hisp_stats)
colnames(ugds_hisp_stats) <- "UGDS_HISP"

##UGDS_ASIAN

ugds_asian_stats <- c(median(college_data$UGDS_ASIAN), quantile(college_data$UGDS_ASIAN)[2], quantile(college_data$UGDS_ASIAN)[4],IQR(college_data$UGDS_ASIAN),mean(college_data$UGDS_ASIAN),sd(college_data$UGDS_ASIAN))
names(ugds_asian_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
ugds_asian_stats <- as.data.frame(ugds_asian_stats)
colnames(ugds_asian_stats) <- "UGDS_ASIAN"


##UGDS_AIAN

ugds_aian_stats <- c(median(college_data$UGDS_AIAN), quantile(college_data$UGDS_AIAN)[2], quantile(college_data$UGDS_AIAN)[4],IQR(college_data$UGDS_AIAN),mean(college_data$UGDS_AIAN),sd(college_data$UGDS_AIAN))
names(ugds_aian_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
ugds_aian_stats <- as.data.frame(ugds_aian_stats)
colnames(ugds_aian_stats) <- "UGDS_AIAN"

