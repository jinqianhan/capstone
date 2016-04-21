library(shiny)
source('predict.R')


shinyServer(
        function(input, output){
                output$oid1 <- renderPrint({input$id1})
                output$oid2 <- renderPrint({input$id2})
                output$odate <- renderPrint({input$date})
                
                output$inputValue <- renderPrint({input$glucose})
                output$prediction <- renderPrint({diabetesRisk(input$glucose)})
        }
)
