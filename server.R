options(shiny.maxRequestSize=30*1024^2)
library(shiny)
source('predict.R')

shinyServer(
        function(input, output){
                
                predword <- reactive({predict(input$text)})
                
                output$intext <- renderPrint({input$text})
                output$prediction <- renderPrint({
                        predword()
                })
        }
)
