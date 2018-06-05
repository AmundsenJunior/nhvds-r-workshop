library(shiny)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel('NHV DS App 2'),
    
    fluidRow(
        column(3, 
               sliderInput('min_mpg',
                           'Select minimum MPG',
                           min = 5,
                           max = 70,
                           value = 20),
               numericInput('max_mpg',
                            'Select maximum MPG',
                            min = 5,
                            max = 70,
                            value = 40),
               # could also use two-way slider, where value = c(20, 40), but it returns a string of '20 40', that you'd have to split on the space, server-side
               fileInput('file1',
                         'Upload your data',
                         accept = c('text/csv',
                                    'text/comma-separated-values',
                                    '.csv')
                )
        ),
        column(6,
               tableOutput('myTable')
        )
    )
    
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$myTable <- renderTable({
        
        inFile <- input$file1
        if(is.null(inFile)) {
            temp <- mtcars
        } else {
            temp <- read.csv(inFile$datapath)
        }
        
        temp %>%
            filter(mpg >= input$min_mpg, mpg <= input$max_mpg)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)