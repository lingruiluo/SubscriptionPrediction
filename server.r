shinyServer(
  function(input, output, session) {

    # get the training dataset
    myTrain <- reactive({
      data = read.csv("cleaned_data_additional_full.csv")[,-1]
      data[data == "unknown"] = NA
      levels(data$y) = c(0, 1)
      # select desired variables
      data = data %>%
        select(-c(emp.var.rate, euribor3m, duration))
      # get train data
      set.seed(2383)
      size = floor(0.75 * nrow(data))
      train_index <- sample(seq_len(nrow(data)), size = size)
      train = data[train_index,]
    })
    
    # train the model
    myMod <- reactive({
      logit_mod <- glm(y ~ ., data = myTrain(), family = binomial)
      return(logit_mod)
    })
    
    # Make the selected variables a new dataframe
    selectData <- reactive({
      data <- data.frame(input$age, input$job, input$marital, input$edu, input$default, 
                         input$housing, input$loan, input$contact, input$month, 
                         input$day_of_week, input$campaign, input$pdays, input$previous, 
                         input$poutcome, input$cons.price.idx, input$cons.conf.idx, 
                         input$nr.employed
                         )
      colnames(data) <- c(colnames(myTrain()[-18]))
      return(data)
    })
    
    prediction <- reactive({
      logit_pred = predict(myMod(), selectData(), type = "response")
      logit_pred = ifelse(logit_pred > 0.2, 1, 0)
      return(logit_pred)
    })
    
    output$text.output <- renderText({
      prediction()
    })

  }
)