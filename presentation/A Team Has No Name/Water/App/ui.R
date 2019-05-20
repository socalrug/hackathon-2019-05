# Define UI for application that draws a histogram
shinyUI(
    
navbarPage("Water Data", 
    tabPanel("Violations",
            fluidRow(
                column(1),
                column(11, selectInput("area", "Violations by", choices = c("COUNTY", "ZIPCODE")))
            ),
            fluidRow(
                withSpinner(leafletOutput("imap", height = 800))
            )
    ),
    tabPanel("Stations",
             fluidRow(
                 column(1),
                 column(11, h3("Stations - Dry History"))
             ),
             fluidRow(
                 withSpinner(leafletOutput("imap2", height = 800))
             ))
))

