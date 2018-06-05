library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("NHV DS App 1"),
   
   fluidRow(
       column(3, 
              selectInput('hist_var',
                          'Please select variable',
                          c('MPG' = 'mpg', 'Weight' = 'wt')
              ),
              textInput('hist_title',
                        'Please define a chart title',
                        value = 'MTCARS Histogram')
       ),
       column(9,
              plotOutput('hist_plot')
       )
   )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$hist_plot <- renderPlot({
        ggplot(mtcars) +
            geom_histogram(aes_string(input$hist_var)) +
            labs(title = input$hist_title)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

