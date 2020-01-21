library(shinydashboard)
library(shinythemes)

ui <- dashboardPage(
  dashboardHeader(title = "Subscription Prediction"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(tags$em("Upload Test Data"), icon=icon("upload"),tabName = "upload"),
      menuItem(tags$em("Download Predictions"), icon=icon("download"),tabName = "download")
    )
  ),
  dashboardBody(
    tabItems(
      # upload
      tabItem(tabName = 'upload',
              tags$h1("Welcome to the Subscription Prediction Shiny App!"),
              tags$h4("This app is desigend to give you predictions on whether the client
                      will subscribe to a term deposit or not. By simply uploading a csv file
                      containing the variables needed, you can get the prediction results and 
                      download it for your futher use."),
              column(width = 4,
                     fileInput('test_data', h3('Upload test data in csv format ',
                                           style="color:blue;font-size:130%"),
                               multiple = FALSE,accept=c('.csv'))),
              # uiOutput("input_data"),
              tableOutput("res")
              
      ),
      
      # download
      tabItem(tabName = 'download',
              tags$h4("Click the 'Download Predictions' button to download the predictions in csv format."),
              column(width = 4,
                     downloadButton("downloadData", 
                                    em('Download Predictions',
                                       style="color:blue;font-size:130%")))
             )
    )
  )
)