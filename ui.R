library(shiny)

shinyUI(
        pageWithSidebar(
                headerPanel("Illustrating inputs and Diabetes prediction"),
                # Application title
                sidebarPanel(
                        numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
                        checkboxGroupInput("id2", "Checkbox",
                                           c("Value 1" = "1",
                                             "Value 2" = "2",
                                             "Value 3" = "3")),
                        dateInput("date", "Date:"),
                        
                        numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
                        submitButton('Submit')
                ),
                
                
                
                mainPanel(
                        h3('Illustrating outputs'),
                        h4('You entered'),
                        verbatimTextOutput("oid1"),
                        h4('You entered'),
                        verbatimTextOutput("oid2"),
                        h4('You entered'),
                        verbatimTextOutput("odate"),
                        
                        h3('Results of prediction'),
                        h4('You entered'),
                        verbatimTextOutput("inputValue"),
                        h4('Which resulted in a prediction of '),
                        verbatimTextOutput("prediction")
                )
        )
)