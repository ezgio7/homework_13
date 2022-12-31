library(shiny)
library(ggplot2)

ui <- fluidPage(

  titlePanel("Miles Per Gallon"),
  

  sidebarLayout(
    
    sidebarPanel(
      selectInput("type","Variable",
                  c("Cylinders"="cyl",
                    "Engine type"="vs",
                    "Transmission"="am",
                    "Number of gears"="gear",
                    "Number of carburetors"="carb")
                  )
    ),
    mainPanel(
      h3(textOutput("caption")),
      plotOutput(outputId = "plots")
      
    )
  )
)

server <- function(input, output) {
  formulaText <- reactive({
    paste("mpg ~", input$type)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  output$plots <- renderPlot({
    ggplot(data=mtcars,aes(mpg))+geom_histogram(binwidth =5, fill="blue")+
      facet_wrap(~mtcars[[input$type]],ncol=1)
  })
  
}

shinyApp(ui = ui, server = server)
