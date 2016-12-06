.PHONY: all data eda regressions \
regression-diversity ols-diversity ridge-diversity lasso-diversity pcr-diversity plsr-diversity \
regression-grad-rate ols-grad-rate ridge-grad-rate lasso-grad-rate pcr-grad-rate plsr-grad-rate \
report slides session clean tests shiny

data_clean_script = code/scripts/data-cleaning.R
data_train_test_split_script = code/scripts/train-test-split.R
DATA = data/original-data/Most-Recent-Cohorts-All-Data-Elements.csv
CLEAN_DATA = data/cleaned-data/*.csv
report_sections = sections/*.Rnw

all: data eda tests regressions report slides

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
eda: code/scripts/eda-script.R $(CLEAN_DATA)
	RScript $<

regressions: $(CLEAN_DATA)
	make regressions-diversity
	make regressions-grad-rate

# regressions on diversity
regressions-diversity: $(DATA)
	make ols-diversity
	make ridge-diversity
	make lasso-diversity
	make pcr-diversity
	make plsr-diversity

ols-diversity: code/scripts/ols-regression-diversity.R $(CLEAN_DATA)
	RScript $<
	
ridge-diversity: code/scripts/ridge-regression-diversity.R $(CLEAN_DATA)
	RScript $<

lasso-diversity: code/scripts/lasso-regression-diversity.R $(CLEAN_DATA)
	RScript $<

pcr-diversity: code/scripts/pcr-regression-diversity.R $(CLEAN_DATA)
	RScript $<
	
plsr-diversity: code/scripts/plsr-regression-diversity.R $(CLEAN_DATA)
	RScript $<

# regressions on graduation rate
regressions-grad-rate: $(CLEAN_DATA)
	make ols-grad-rate
	make ridge-grad-rate
	make lasso-grad-rate
	make pcr-grad-rate
	make plsr-grad-rate

ols-grad-rate: code/scripts/ols-regression-grad-rate.R $(CLEAN_DATA)
	RScript $<
	
ridge-grad-rate: code/scripts/ridge-regression-grad-rate.R $(CLEAN_DATA)
	RScript $<

lasso-grad-rate: code/scripts/lasso-regression-grad-rate.R $(CLEAN_DATA)
	RScript $<

pcr-grad-rate: code/scripts/pcr-regression-grad-rate.R $(CLEAN_DATA)
	RScript $<

plsr-grad-rate: code/scripts/plsr-regression-grad-rate.R $(CLEAN_DATA)
	RScript $<

# generate session information including system spec and required packages
session: 
	bash session.sh
	
# assemble sections of report into one and convert it to PDF format
report:
	cd report; cat $(report_sections) > report.Rnw
	cd report; R -e "library(knitr); Sweave2knitr('report.rnw')"; Rscript -e "library(knitr); knit('report-knitr.rnw')"; pdflatex report-knitr.tex; mv report-knitr.pdf report.pdf
	
# generate slides
slides: $(CLEAN_DATA)
	Rscript -e "library(rmarkdown); render('slides/slides.Rmd', 'ioslides_presentation')"
	
# run shiny app
shiny: $(CLEAN_DATA)
	R -e "shiny::runApp('shiny/', launch.browser=TRUE)"
	
# run tests
tests: code/test-that.R code/tests/test-regression.R
	Rscript $<

# remove existing report and slides
clean:
	rm -f report/report.pdf
	rm -f slides/slides.html


