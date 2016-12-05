.PHONY: all data eda regressions \
regression-diversity ols-diversity ridge-diversity lasso-diversity pcr-diversity plsr-diversity \
regression-grad-rate ols-grad-rate ridge-grad-rate lasso-grad-rate pcr-grad-rate plsr-grad-rate \
report slides session clean

data_clean_script = code/scripts/data-cleaning.R
data_train_test_split_script = code/scripts/train-test-split.R
DATA = data/original-data/Most-Recent-Cohorts-All-Data-Elements.csv
CLEAN_DATA = data/cleaned-data/*.csv
report_sections = sections/*.Rnw

all: data eda regressions report slides

# download latest data & data cleaning & split data into train set and test set
data:
	cd data/original-data && curl -O https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-All-Data-Elements.csv
	make data_clean
	make data_train_test_split
	
data_clean: $(data_clean_script)
	RScript $<

data_train_test_split: $(data_train_test_split_script)
	RScript $<
	
# run exploratory data analysis
eda: code/scripts/eda-script.R $(DATA)
	RScript $<

regressions: $(DATA)
	make regressions-diversity
	make regressions-grad-rate

# regressions on diversity
regressions-diversity: $(DATA)
	make ols-diversity
	make ridge-diversity
	make lasso-diversity
	make pcr-diversity
	make plsr-diversity

ols-diversity: code/scripts/ols-regression-diversity.R $(DATA)
	RScript $<
	
ridge-diversity: code/scripts/ridge-regression-diversity.R $(DATA)
	RScript $<

lasso-diversity: code/scripts/lasso-regression-diversity.R $(DATA)
	RScript $<

pcr-diversity: code/scripts/pcr-regression-diversity.R $(DATA)
	RScript $<
	
plsr-diversity: code/scripts/plsr-regression-diversity.R $(DATA)
	RScript $<

# regressions on graduation rate
regressions-grad-rate: $(DATA)
	make ols-grad-rate
	make ridge-grad-rate
	make lasso-grad-rate
	make pcr-grad-rate
	make plsr-grad-rate

ols-grad-rate: code/scripts/ols-regression-grad-rate.R $(DATA)
	RScript $<
	
ridge-grad-rate: code/scripts/ridge-regression-grad-rate.R $(DATA)
	RScript $<

lasso-grad-rate: code/scripts/lasso-regression-grad-rate.R $(DATA)
	RScript $<

pcr-grad-rate: code/scripts/pcr-regression-grad-rate.R $(DATA)
	RScript $<

plsr-grad-rate: code/scripts/plsr-regression-grad-rate.R $(DATA)
	RScript $<

# generate session information including system spec and required packages
session: 
	bash session.sh
	
# assemble sections of report into one and convert it to PDF format
report:
	cd report; cat $(report_sections) > report.Rnw
	Rscript -e "library(rmarkdown); render('report/report.Rnw', 'pdf_document')"
	
# generate slides
slides:
	Rscript -e "library(rmarkdown); render('slides/slides.Rmd', 'ioslides_presentation')"

# remove existing report and slides
clean:
	rm -f report/report.pdf
	rm -f slides/slides.html



