library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
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
  )
))