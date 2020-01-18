shinyUI(
  pageWithSidebar(
    headerPanel('Will the client subscribe to a term deposit?'),
    sidebarPanel(
      numericInput('age', 'Age', 0,
                   min = 0, max = 120),
      selectInput('job', 'Job', c('admin','blue-collar',
                                  'entrepreneur','housemaid',
                                  'management','retired',
                                  'self-employed','services',
                                  'student','technician',
                                  'unemployed')),
      selectInput('marital', 'Marital Status', c('divorced','married','single')),
      selectInput('edu', 'Education', c('basic.4y','basic.6y',
                                        'basic.9y','high.school',
                                        'illiterate','professional.course',
                                        'university.degree')),
      radioButtons('default', 'Has credit in default?', c('yes', 'no')),
      radioButtons('housing', 'Has housing loan?', c('yes', 'no')),
      radioButtons('loan', 'Has personal loan?', c('yes', 'no')),
      radioButtons('contact', 'Contact communication type?', c('celluar', 'telephone')),
      selectInput('month', 'Last contact month of year', c('jan','feb',
                                                           'mar','apr',
                                                           'may','jun',
                                                           'jul','aug',
                                                           'sep','oct',
                                                           'nov', 'dec')),
      selectInput('day_of_week', 'Last contact day of week', c('mon','tue',
                                                               'wed','thu',
                                                               'fri')),
      
      
      numericInput('campaign', 'Number of contacts performed during the campaign for this client',
                   0, min = 0, max = 200),
      numericInput('numeric', 'Number of contacts performed before this campaign for this client',
                   0, min = 0, max = 200),
      radioButtons('poutcome', 'Outcome of the previous marketing campaign', c('failure','nonexistent','success')),
      numericInput('cons.price.idx', 'Consumer price index - monthly indicator',
                   0, min = 0, max = 100),
      numericInput('cons.conf.idx', 'Consumer confidence index - monthly indicator',
                   0, min = -100, max = 0),
      numericInput('nr.employed', 'Number of Employees - quarterly indicator',
                   0, min = 0, max = 1000000)
    ),
    mainPanel(
      plotOutput('plot1')
    )
  )
)
