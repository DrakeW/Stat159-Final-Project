library(shiny)
library(leaflet)
library(RColorBrewer)
library(dplyr)
library(lattice)

clean_data <- read.csv(file = "../data/cleaned-data/clean-data-w-geo.csv")

ui2 <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(fixed = TRUE,
                draggable = TRUE, top = 70, left = 20, right = 'auto', bottom = "auto",
                width = 600, height = "auto",
                selectInput(inputId = "city", "City", choices = clean_data$CITY),
                titlePanel("Histograms of Different Data"),
                sidebarLayout(
                  sidebarPanel(
                    helpText("Please Pick a Distribution that you are interested in"),
                    selectInput("var", 
                                label = "Choose a variable to display",
                                choices = c("Men Histogram", "Women Histogram",
                                            "White Histogram", "Asian Histogram", "AIAN Histogram", "First Generation College Student",
                                            "First Generation College Student", "Married Student", "Federal Loans", "Debt Median", 
                                            "Mean Earnings", "Gender Diversity", "Race Divesity", "Gender Diversity", "Marital Diversity",
                                            "First Generation Diversity Score", "Combined Diversity Score"),
                                selected = "Men Histogram")
                  ),
                  mainPanel(
                    textOutput("Stats159"),
                    textOutput("text2"),
                    plotOutput("histoPlot")
                  )
                ))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  filter_by_city <- reactive({
    clean_data[clean_data$CITY==input$city, ]
  })
  
  filter_by_div <- reactive({
    clean_data[clean_data$DIV_SCORE <= input$level * 0.25]
  })
  
  output$map <- renderLeaflet({
    leaflet(clean_data) %>%  addTiles(
      urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
      attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
    ) %>% addCircles(data = clean_data, lat = ~LATITUDE, lng = ~LONGITUDE)
  })
  
  observe({
    leafletProxy("map", data = filter_by_city()) %>%  addTiles(
      urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
      attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
    ) %>% clearShapes() %>% addCircles(~LONGITUDE,~LATITUDE,radius = 200, stroke=FALSE, fillOpacity=0.4, fillColor="red", 
         popup = ~paste("<strong>University: </strong>", INSTNM,
                        "<br><strong>City, State: </strong>", CITY, STABBR,
                        "<br><strong>Percent of students with loan: </strong>", PCTFLOAN,
                        "<br><strong>Diversity score: </strong>", DIV_SCORE,
                        "<br><strong>Median earnings: </strong>", MN_EARN_WNE_P10
         ) 
      )
  })
  
  observe({
    proxy <- leafletProxy("map", data = filter_by_city())
    proxy %>%
      fitBounds(~min(LONGITUDE)-0.0001 , ~min(LATITUDE)-0.0001, ~max(LONGITUDE), ~max(LATITUDE))
  })
  
  output$histoPlot <- renderPlot({
    college_data <- read.csv("../data/cleaned-data/clean-data.csv")
    
    if (input$var == 'Men Histogram') {
      men_stats <- c(median(college_data$UGDS_MEN), quantile(college_data$UGDS_MEN)[2], quantile(college_data$UGDS_MEN)[4],IQR(college_data$UGDS_MEN),mean(college_data$UGDS_MEN),sd(college_data$UGDS_MEN))
      names(men_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      men_stats <- as.data.frame(men_stats)
      colnames(men_stats) <- "MEN"
      hist(college_data$UGDS_MEN, main="Histogram of Men", xlab="Percent")     
    } else if (input$var == 'Women Histogram') {
      women_stats <- c(median(college_data$UGDS_WOMEN), quantile(college_data$UGDS_WOMEN)[2], quantile(college_data$UGDS_WOMEN)[4],IQR(college_data$UGDS_WOMEN),mean(college_data$UGDS_WOMEN),sd(college_data$UGDS_WOMEN))
      names(women_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      women_stats <- as.data.frame(women_stats)
      colnames(women_stats) <- "WOMEN"
      hist(college_data$UGDS_WOMEN, main="Histogram of Women", xlab="Percent")
    } else if (input$var == "White Histogram") {
      white_stats <- c(median(college_data$UGDS_WHITE), quantile(college_data$UGDS_WHITE)[2], quantile(college_data$UGDS_WHITE)[4],IQR(college_data$UGDS_WHITE),mean(college_data$UGDS_WHITE),sd(college_data$UGDS_WHITE))
      names(white_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      white_stats <- as.data.frame(white_stats)
      colnames(white_stats) <- "WHITE"
      hist(college_data$UGDS_HISP, main="Histogram of Hispanic", xlab="Percent")
    } else if (input$var == "Asian Histogram") {
      asian_stats <- c(median(college_data$UGDS_ASIAN), quantile(college_data$UGDS_ASIAN)[2], quantile(college_data$UGDS_ASIAN)[4],IQR(college_data$UGDS_ASIAN),mean(college_data$UGDS_ASIAN),sd(college_data$UGDS_ASIAN))
      names(asian_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      asian_stats <- as.data.frame(asian_stats)
      colnames(asian_stats) <- "ASIAN"
      hist(college_data$UGDS_ASIAN, main="Histogram of Asian", xlab="Percent")
    } else if (input$var == "AIAN Histogram") {
      aian_stats <- c(median(college_data$UGDS_AIAN), quantile(college_data$UGDS_AIAN)[2], quantile(college_data$UGDS_AIAN)[4],IQR(college_data$UGDS_AIAN),mean(college_data$UGDS_AIAN),sd(college_data$UGDS_AIAN))
      names(aian_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      aian_stats <- as.data.frame(aian_stats)
      colnames(aian_stats) <- "AMERICAN INDIAN"
      hist(college_data$UGDS_AIAN, main="Histogram of American Indian", xlab="Percent")
      
    } else if (input$var == "First Generation College Student") {
      first_gen_stats <- c(median(college_data$FIRST_GEN), quantile(college_data$FIRST_GEN)[2], quantile(college_data$FIRST_GEN)[4],IQR(college_data$FIRST_GEN),mean(college_data$FIRST_GEN),sd(college_data$FIRST_GEN))
      names(first_gen_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      first_gen_stats <- as.data.frame(first_gen_stats)
      colnames(first_gen_stats) <- "FIRST GEN"
      hist(college_data$FIRST_GEN, main="Histogram of First Generation", xlab="Percent")
      
    } else if (input$var == "Married Student") {
      married_stats <- c(median(college_data$MARRIED), quantile(college_data$MARRIED)[2], quantile(college_data$MARRIED)[4],IQR(college_data$MARRIED),mean(college_data$MARRIED),sd(college_data$MARRIED))
      names(married_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      married_stats <- as.data.frame(married_stats)
      colnames(married_stats) <- "MARRIED"
      hist(college_data$MARRIED, main="Histogram of Married", xlab="Percent")
      
    } else if (input$var == "Federal Loans") {
      pctfloan_stats <- c(median(college_data$PCTFLOAN), quantile(college_data$PCTFLOAN)[2], quantile(college_data$PCTFLOAN)[4],IQR(college_data$PCTFLOAN),mean(college_data$PCTFLOAN),sd(college_data$PCTFLOAN))
      names(pctfloan_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      pctfloan_stats <- as.data.frame(pctfloan_stats)
      colnames(pctfloan_stats) <- "PCT FEDERAL LOAN"
      hist(college_data$PCTFLOAN, main="Histogram of Federal Loans", xlab="Percent")
      
    } else if (input$var == "Debt Median") {
      debt_mdn_stats <- c(median(college_data$DEBT_MDN), quantile(college_data$DEBT_MDN)[2], quantile(college_data$DEBT_MDN)[4],IQR(college_data$DEBT_MDN),mean(college_data$DEBT_MDN),sd(college_data$DEBT_MDN))
      names(debt_mdn_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      debt_mdn_stats <- as.data.frame(debt_mdn_stats)
      colnames(debt_mdn_stats) <- "MEDIAN DEBT"
      hist(college_data$DEBT_MDN, main="Histogram of Debt Median", xlab="Percent")
      
    } else if (input$var == "Mean Earnings") {
      mn_earn_stats <- c(median(college_data$MN_EARN_WNE_P10), quantile(college_data$MN_EARN_WNE_P10)[2], quantile(college_data$MN_EARN_WNE_P10)[4],IQR(college_data$MN_EARN_WNE_P10),mean(college_data$MN_EARN_WNE_P10),sd(college_data$MN_EARN_WNE_P10))
      names(mn_earn_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      mn_earn_stats <- as.data.frame(mn_earn_stats)
      colnames(mn_earn_stats) <- "MEAN EARNINGS"
      hist(college_data$MN_EARN_WNE_P10, main="Histogram of Mean Earnings", xlab="Percent")
      
    } else if (input$var == "Gender Diversity") {
      gen_div_stats <- c(median(college_data$GENDER_DIV), quantile(college_data$GENDER_DIV)[2], quantile(college_data$GENDER_DIV)[4],IQR(college_data$GENDER_DIV),mean(college_data$GENDER_DIV),sd(college_data$GENDER_DIV))
      names(gen_div_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      gen_div_stats <- as.data.frame(gen_div_stats)
      colnames(gen_div_stats) <- "GENDER DIV"
      hist(college_data$GENDER_DIV, main="Histogram of Gender Diversity", xlab="Percent")
      
    } else if (input$var == "Race Divesity") {
      race_div_stats <- c(median(college_data$RACE_DIV), quantile(college_data$RACE_DIV)[2], quantile(college_data$RACE_DIV)[4],IQR(college_data$RACE_DIV),mean(college_data$RACE_DIV),sd(college_data$RACE_DIV))
      names(race_div_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      race_div_stats <- as.data.frame(race_div_stats)
      colnames(race_div_stats) <- "RACE DIV"
      hist(college_data$RACE_DIV, main="Histogram of Race Diversity", xlab="Percent")
      
    } else if (input$var == "Marital Diversity") {
      marital_div_stats <- c(median(college_data$MARITAL_STATUS_DIV), quantile(college_data$MARITAL_STATUS_DIV)[2], quantile(college_data$MARITAL_STATUS_DIV)[4],IQR(college_data$MARITAL_STATUS_DIV),mean(college_data$MARITAL_STATUS_DIV),sd(college_data$MARITAL_STATUS_DIV))
      names(marital_div_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      marital_div_stats <- as.data.frame(marital_div_stats)
      colnames(marital_div_stats) <- "MARITAL STATUS DIV"
      hist(college_data$MARITAL_STATUS_DIV, main="Histogram of Marital Status Diversity", xlab="Percent")
      
    } else if (input$var == "First Generation Diversity Score") {
      first_gen_div_stats <- c(median(college_data$FIRST_GEN_DIV), quantile(college_data$FIRST_GEN_DIV)[2], quantile(college_data$FIRST_GEN_DIV)[4],IQR(college_data$FIRST_GEN_DIV),mean(college_data$FIRST_GEN_DIV),sd(college_data$FIRST_GEN_DIV))
      names(first_gen_div_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      first_gen_div_stats <- as.data.frame(first_gen_div_stats)
      colnames(first_gen_div_stats) <- "FIRST GEN DIV"
      hist(college_data$FIRST_GEN_DIV, main="Histogram of Gender Diversity", xlab="Percent")
      
    } else if (input$var == "Combined Diversity Score") {
      div_score_stats <- c(median(college_data$DIV_SCORE), quantile(college_data$DIV_SCORE)[2], quantile(college_data$DIV_SCORE)[4],IQR(college_data$DIV_SCORE),mean(college_data$DIV_SCORE),sd(college_data$DIV_SCORE))
      names(div_score_stats) <- c("Median", "First Quartile", "Third Quartile", "IQR", "Mean", "Std. Deviation")
      div_score_stats <- as.data.frame(div_score_stats)
      colnames(div_score_stats) <- "DIV_SCORE"
      hist(college_data$DIV_SCORE, main="Histogram of Diversity Score", xlab="Percent")
    }
  })
}

shinyApp(ui2, server)