college_data <- read.csv("data/cleaned-data/clean-data.csv")

#Quantitative Variables 

##MEN 

men_stats <- c(median(college_data$UGDS_MEN), quantile(college_data$UGDS_MEN)[2], quantile(college_data$UGDS_MEN)[4],IQR(college_data$UGDS_MEN),mean(college_data$UGDS_MEN),sd(college_data$UGDS_MEN))
names(men_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
men_stats <- as.data.frame(men_stats)
colnames(men_stats) <- "MEN"

png("images/men-histogram.png")
hist(college_data$UGDS_MEN, main="Histogram of Men", xlab="Percent")
dev.off() 


##WOMEN

women_stats <- c(median(college_data$UGDS_WOMEN), quantile(college_data$UGDS_WOMEN)[2], quantile(college_data$UGDS_WOMEN)[4],IQR(college_data$UGDS_WOMEN),mean(college_data$UGDS_WOMEN),sd(college_data$UGDS_WOMEN))
names(women_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
women_stats <- as.data.frame(women_stats)
colnames(women_stats) <- "WOMEN"

png("images/women-histogram.png")
hist(college_data$UGDS_WOMEN, main="Histogram of Women", xlab="Percent")
dev.off() 


##WHITE

white_stats <- c(median(college_data$UGDS_WHITE), quantile(college_data$UGDS_WHITE)[2], quantile(college_data$UGDS_WHITE)[4],IQR(college_data$UGDS_WHITE),mean(college_data$UGDS_WHITE),sd(college_data$UGDS_WHITE))
names(white_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
white_stats <- as.data.frame(white_stats)
colnames(white_stats) <- "WHITE"

png("images/white-histogram.png")
hist(college_data$UGDS_WHITE, main="Histogram of White", xlab="Percent")
dev.off() 


##BLACK

black_stats <- c(median(college_data$UGDS_BLACK), quantile(college_data$UGDS_BLACK)[2], quantile(college_data$UGDS_BLACK)[4],IQR(college_data$UGDS_BLACK),mean(college_data$UGDS_BLACK),sd(college_data$UGDS_BLACK))
names(black_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
black_stats <- as.data.frame(black_stats)
colnames(black_stats) <- "BLACK"

png("images/black-histogram.png")
hist(college_data$UGDS_BLACK, main="Histogram of Black", xlab="Percent")
dev.off() 


##HISP

hisp_stats <- c(median(college_data$UGDS_HISP), quantile(college_data$UGDS_HISP)[2], quantile(college_data$UGDS_HISP)[4],IQR(college_data$UGDS_HISP),mean(college_data$UGDS_HISP),sd(college_data$UGDS_HISP))
names(hisp_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
hisp_stats <- as.data.frame(hisp_stats)
colnames(hisp_stats) <- "HISPANIC"

png("images/hispanic-histogram.png")
hist(college_data$UGDS_HISP, main="Histogram of Hispanic", xlab="Percent")
dev.off() 


##ASIAN

asian_stats <- c(median(college_data$UGDS_ASIAN), quantile(college_data$UGDS_ASIAN)[2], quantile(college_data$UGDS_ASIAN)[4],IQR(college_data$UGDS_ASIAN),mean(college_data$UGDS_ASIAN),sd(college_data$UGDS_ASIAN))
names(asian_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
asian_stats <- as.data.frame(asian_stats)
colnames(asian_stats) <- "ASIAN"

png("images/asian-histogram.png")
hist(college_data$UGDS_ASIAN, main="Histogram of Asian", xlab="Percent")
dev.off() 



##AIAN

aian_stats <- c(median(college_data$UGDS_AIAN), quantile(college_data$UGDS_AIAN)[2], quantile(college_data$UGDS_AIAN)[4],IQR(college_data$UGDS_AIAN),mean(college_data$UGDS_AIAN),sd(college_data$UGDS_AIAN))
names(aian_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
aian_stats <- as.data.frame(aian_stats)
colnames(aian_stats) <- "AMERICAN INDIAN"

png("images/american-indian-histogram.png")
hist(college_data$UGDS_AIAN, main="Histogram of American Indian", xlab="Percent")
dev.off() 


##FIRST_GEN 

first_gen_stats <- c(median(college_data$FIRST_GEN), quantile(college_data$FIRST_GEN)[2], quantile(college_data$FIRST_GEN)[4],IQR(college_data$FIRST_GEN),mean(college_data$FIRST_GEN),sd(college_data$FIRST_GEN))
names(first_gen_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
first_gen_stats <- as.data.frame(first_gen_stats)
colnames(first_gen_stats) <- "FIRST GEN"

png("images/first-gen-histogram.png")
hist(college_data$FIRST_GEN, main="Histogram of First Generation", xlab="Percent")
dev.off() 



##MARRIED

married_stats <- c(median(college_data$MARRIED), quantile(college_data$MARRIED)[2], quantile(college_data$MARRIED)[4],IQR(college_data$MARRIED),mean(college_data$MARRIED),sd(college_data$MARRIED))
names(married_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
married_stats <- as.data.frame(married_stats)
colnames(married_stats) <- "MARRIED"

png("images/married-histogram.png")
hist(college_data$MARRIED, main="Histogram of Married", xlab="Percent")
dev.off() 



##PCTFLOAN

pctfloan_stats <- c(median(college_data$PCTFLOAN), quantile(college_data$PCTFLOAN)[2], quantile(college_data$PCTFLOAN)[4],IQR(college_data$PCTFLOAN),mean(college_data$PCTFLOAN),sd(college_data$PCTFLOAN))
names(pctfloan_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
pctfloan_stats <- as.data.frame(pctfloan_stats)
colnames(pctfloan_stats) <- "PCT FEDERAL LOAN"

png("images/pctfloan-histogram.png")
hist(college_data$PCTFLOAN, main="Histogram of Federal Loans", xlab="Percent")
dev.off() 


##DEBT_MDN

debt_mdn_stats <- c(median(college_data$DEBT_MDN), quantile(college_data$DEBT_MDN)[2], quantile(college_data$DEBT_MDN)[4],IQR(college_data$DEBT_MDN),mean(college_data$DEBT_MDN),sd(college_data$DEBT_MDN))
names(debt_mdn_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
debt_mdn_stats <- as.data.frame(debt_mdn_stats)
colnames(debt_mdn_stats) <- "MEDIAN DEBT"

png("images/debt-histogram.png")
hist(college_data$DEBT_MDN, main="Histogram of Debt Median", xlab="Percent")
dev.off() 


##MN_EARN_WNE_P10

mn_earn_stats <- c(median(college_data$MN_EARN_WNE_P10), quantile(college_data$MN_EARN_WNE_P10)[2], quantile(college_data$MN_EARN_WNE_P10)[4],IQR(college_data$MN_EARN_WNE_P10),mean(college_data$MN_EARN_WNE_P10),sd(college_data$MN_EARN_WNE_P10))
names(mn_earn_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
mn_earn_stats <- as.data.frame(mn_earn_stats)
colnames(mn_earn_stats) <- "MEAN EARNINGS"

png("images/mn-earnings-histogram.png")
hist(college_data$MN_EARN_WNE_P10, main="Histogram of Mean Earnings", xlab="Percent")
dev.off() 


##GENDER_DIV 

gen_div_stats <- c(median(college_data$GENDER_DIV), quantile(college_data$GENDER_DIV)[2], quantile(college_data$GENDER_DIV)[4],IQR(college_data$GENDER_DIV),mean(college_data$GENDER_DIV),sd(college_data$GENDER_DIV))
names(gen_div_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
gen_div_stats <- as.data.frame(gen_div_stats)
colnames(gen_div_stats) <- "GENDER DIV"

png("images/gender-div-histogram.png")
hist(college_data$GENDER_DIV, main="Histogram of Gender Diversity", xlab="Percent")
dev.off() 


##RACE_DIV 

race_div_stats <- c(median(college_data$RACE_DIV), quantile(college_data$RACE_DIV)[2], quantile(college_data$RACE_DIV)[4],IQR(college_data$RACE_DIV),mean(college_data$RACE_DIV),sd(college_data$RACE_DIV))
names(race_div_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
race_div_stats <- as.data.frame(race_div_stats)
colnames(race_div_stats) <- "RACE DIV"

png("images/race-div-histogram.png")
hist(college_data$RACE_DIV, main="Histogram of Race Diversity", xlab="Percent")
dev.off() 


##MARITAL_STATUS_DIV

marital_div_stats <- c(median(college_data$MARITAL_STATUS_DIV), quantile(college_data$MARITAL_STATUS_DIV)[2], quantile(college_data$MARITAL_STATUS_DIV)[4],IQR(college_data$MARITAL_STATUS_DIV),mean(college_data$MARITAL_STATUS_DIV),sd(college_data$MARITAL_STATUS_DIV))
names(marital_div_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
marital_div_stats <- as.data.frame(marital_div_stats)
colnames(marital_div_stats) <- "MARITAL STATUS DIV"

png("images/married-div-histogram.png")
hist(college_data$MARITAL_STATUS_DIV, main="Histogram of Marital Status Diversity", xlab="Percent")
dev.off() 


##FIRST_GEN_DIV

first_gen_div_stats <- c(median(college_data$FIRST_GEN_DIV), quantile(college_data$FIRST_GEN_DIV)[2], quantile(college_data$FIRST_GEN_DIV)[4],IQR(college_data$FIRST_GEN_DIV),mean(college_data$FIRST_GEN_DIV),sd(college_data$FIRST_GEN_DIV))
names(first_gen_div_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
first_gen_div_stats <- as.data.frame(first_gen_div_stats)
colnames(first_gen_div_stats) <- "FIRST GEN DIV"

png("images/first-gen-div-histogram.png")
hist(college_data$FIRST_GEN_DIV, main="Histogram of Gender Diversity", xlab="Percent")
dev.off() 

##DIV_SCORE 

div_score_stats <- c(median(college_data$DIV_SCORE), quantile(college_data$DIV_SCORE)[2], quantile(college_data$DIV_SCORE)[4],IQR(college_data$DIV_SCORE),mean(college_data$DIV_SCORE),sd(college_data$DIV_SCORE))
names(div_score_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
div_score_stats <- as.data.frame(div_score_stats)
colnames(div_score_stats) <- "DIV_SCORE"

png("images/div-score-histogram.png")
hist(college_data$DIV_SCORE, main="Histogram of Diversity Score", xlab="Percent")
dev.off() 


###Descriptive Stats of All Quantitative Variables 

quant_var_stats <- data.frame(men_stats, women_stats, white_stats, black_stats, hisp_stats, asian_stats, aian_stats, first_gen_stats, married_stats, pctfloan_stats, debt_mdn_stats, mn_earn_stats, gen_div_stats, race_div_stats, marital_div_stats, first_gen_div_stats, div_score_stats)

###Correlation Matrix

mat <- signif(cor(college_data[c(5:15,19,23:29)]),2)
mat[lower.tri(mat)]=""
correlation_matrix <- data.frame(mat)

##eda-output.txt
sink("data/eda-output.txt")
print("Descriptive Statistics")
print(quant_var_stats)
print("Correlation Matrix")
print(correlation_matrix)
sink()

##Frequency Table

frequencyct_table <- table(college_data$HIGHDEG, college_data$PREDDEG, college_data$CONTROL, college_data$ICLEVEL)
frequencyct_final <- subset(as.data.frame(frequencyct_table), Freq>0)
frequencyprop_table <- prop.table(frequencyct_table)
frequencyprop_final <- subset(as.data.frame(frequencyprop_table), Freq>0)
frequency_comb <- merge(frequencyct_final, frequencyprop_final, by=c("Var1", "Var2", "Var3", "Var4"))
colnames(frequency_comb) <- c("Highest Degree", "Predominant Degree", "Control", "Institution Level", "Frequency", "Frequency Proportion")

##Barcharts 
png("images/highdeg-barchart.png")
barplot(table(college_data$HIGHDEG), main="Frequency of Higher Degree")
dev.off()

png("images/preddeg-barchart.png")
barplot(table(college_data$PREDDEG), main="Frequency of Predominant Degree")
dev.off()

png("images/control-barchart.png")
barplot(table(college_data$CONTROL), main="Frequency of Control")
dev.off()

png("images/iclevel-barchart.png")
barplot(table(college_data$ICLEVEL), main="Frequency of Institution Level")
dev.off()

##save rdata 

save(quant_var_stats, correlation_matrix, frequency_comb, file="data/eda-output.RData")