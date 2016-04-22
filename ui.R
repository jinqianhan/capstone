library(shiny)

shinyUI(
        pageWithSidebar(
                headerPanel("Coursera Capstone Word Predictor"),
                # Application title
                sidebarPanel(
                        h3("Please allow the predictor a minute or 2 to load"),
                        textInput("text", label = h2("Type your sentence or phrase"), value = "happy"),
                        helpText("type in a sentence, and the app will try to predict the next word using stupid backoff model"),
                        
                        
                        submitButton('Submit')
                ),
                
                
                
                mainPanel(
                        h3('Results of prediction'),
                        h4('You entered'),
                        verbatimTextOutput("intext"),
                        h4('I predict the next word is '),
                        verbatimTextOutput("prediction")
                )
        )
)