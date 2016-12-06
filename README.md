# Stat159 Final Project

Introduction
---
This project aims to explore factors that contribute to the competitiveness, in terms of graduation rate and diversity, of schools in similar demographics and population centers. The roles of our clients are school administrators who need suggestions about how to make their schools more competitive, and the result from our project will give concrete suggestions about on which aspects should their school improve in order to achive their goal. Our data source of our analysis is [College Scorecard](https://collegescorecard.ed.gov/data/) and our analysis focused on schools within California.

Project Structure
---
Contents are separated into five main sections (with each section corresponding to a directory)
* **Code** -- this is where regression scripts & utility functions & unit tests locate.
* **Data** -- raw data & cleaned data & data created by regressions are saved in this directory.
* **Images** -- images created by exploratory analysis & regression are saved in this direcotry.
* **Report** -- contains a **section** sub-directory that includes all sections of the final report in separate files and final report is dynamically generated and saved here.
* **Slides** -- slides are dynamically generated and saved here.

And the file strucutre of this project is like the following
```
Stat159-Final-Project/
	.gitignore
	README.md
	Makefile
	LICENSE
	report/
		sections/
			00-abstract.Rnw
			01-introduction.Rnw
			02-data.Rnw
			03-methods.Rnw
			04-analysis.Rnw
			05-results.Rnw
			06-conclusions.Rnw
		report.Rnw
		report.pdf
	images/
		... (dynamically generated images)
	data/
	    cleaned-data/
                ... (clean data)
	    ... (dynamically generated data)
	code/
	    functions/
	        ... (utility functions)
	    scripts/
	        ... (regression scripts)
	    tests/
	        ... (unit tests against utility functions)
	shiny/
	    ... (shiny app)
	slides/
	    ...
	session-info.txt (system info)
```

Instruction to Reproduce
---
This project can be reproduced by following the instructions below.

1. Download/Clone this project from GitHub (unzip if downloaded file is in zip format)
2. Open **terminal** or any shell program that supports standard **linux commands**
3. `cd Stat159-Final-Project`
4. `make clean` to remove old compiled artifact
5. `make` to generate new artifact
6. open `report.pdf` with PDF viewer of your choice
7. open `slides.html` with browser of your choice

`Make` Summary
---
This section includes description of different make commands that you can use to reproduce corresponding part of this project

1. `make all` reproduce the entire projects -- download data, run regression analysis, aseemble report etc
2. `make data` downlaod data from internet, run data cleaning script, split data into train set and test set
3. `make eda` run exploratory data analysis script
4. `make regressions` run all regression model scripts together
4. `make regressions-[diversity/grad-rate]` run regression models against diversity/grad-rate
4. `make ols-[diversity/grad-rate]` run OLS regression script against diversity/grad-rate and save result
5. `make ridge-[diversity/grad-rate]` run Ridge regression script against diversity/grad-rate and save result
6. `make lasso-[diversity/grad-rate]` run Lasso regression script against diversity/grad-rate and save result
7. `make pcr-[diversity/grad-rate]` run PCR regression script against diversity/grad-rate and save result
8. `make plsr-[diversity/grad-rate]` run PLSR regression script against diversity/grad-rate and save result
10. `make session` run session info script and store system & package infromation into session-info.txt
11. `make report` assemble report from Rmd files in sections and transform to PDF format
12. `make slides` create slides from Rmd files
13. `make clean` remove old artifacts
14. `make tests` to run unit test in _tests_ directory


Author
---
Junyu Wang

Nichole Ann Rethmeier

Jie Sun

Mingtao Fang

License
---
![](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)

ALl media content is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/.)

All code is licensed under **MIT license**.
