library(shiny)
library(shinydashboard)
library(mice)
library(dplyr)

load("LogisticRegression.rda")

server <- function(input, output) {
  
  data = reactive({
    # read the data from input
    data = read.csv(input$test_data$datapath, header = TRUE, sep = ';')
    
    data[data == "unknown"] = NA
    
    # impute missing values
    withProgress(message = 'Imputing missing values...',{
      data = mice(data, maxit = 1, method = 'pmm', seed = 6)
      data = complete(data)
    })
    
    return(data)
  })
  
  results <- reactive({
    # null check
    if(is.null(input$test_data)){
      return(NULL)
    }
    # make predictions
    withProgress(message = 'Making predictions...',{
    prediction <- logit_mod %>% predict(data() , type = "response")
    prediction = ifelse(prediction > 0.2, "yes", "no")
    })
    
    # append predictions
    pred_df <- cbind(data(), prediction)
    pred_df
  })
  
  
  output$res <- reactive({
    results()
  })
  
  # download predictions
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("predictions", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(results(), file, row.names = FALSE)
    })
  
}