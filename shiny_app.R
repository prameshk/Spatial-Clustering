library(leaflet) #For open street map in Shiny application
library(dplyr) #To deal with the data

#This block is UI
ui <- fluidPage(
  pageWithSidebar(
    headerPanel('clustering of UPass Data'),
    sidebarPanel(
      numericInput('eps', 'Please enter Eps value', 0.01),
      numericInput('minpts', 'Please enter MinPts value', 6),
      selectInput('season', "Please select the semester", unique(cl_data$season)),
      column(5, 
             radioButtons('radio', 'Please select the time range', choices = c("01:00:00", "02:00:00", "03:00:00", "04:00:00", "05:00:00", "06:00:00", "07:00:00", "08:00:00", "09:00:00", "10:00:00", "11:00:00", "12:00:00", "13:00:00", "14:00:00", "15:00:00", "16:00:00", "17:00:00", "18:00:00", "19:00:00", "20:00:00", "21:00:00", "22:00:00", "23:00:00", "24:00:00"))), 
      column(5, radioButtons('radio2', 'Please select the time range', choices = c("01:00:00", "02:00:00", "03:00:00", "04:00:00", "05:00:00", "06:00:00", "07:00:00", "08:00:00", "09:00:00", "10:00:00", "11:00:00", "12:00:00", "13:00:00", "14:00:00", "15:00:00", "16:00:00", "17:00:00", "18:00:00", "19:00:00", "20:00:00", "21:00:00", "22:00:00", "23:00:00", "24:00:00"))
      )),
    mainPanel(
      leafletOutput('plot2'),
      verbatimTextOutput("console")
    )
  )
)

#This is server function
server <- function(input, output, session) {
  library(dbscan)
  library(fpc)
  
  # Combine the selected variables into a new data frame
  pp <- reactive({
    dbscan(select(cl_data[cl_data$season == input$season & cl_data$time_ >= input$radio & cl_data$time_ <= input$radio2, ], lat, lon), eps = input$eps, MinPts = input$minpts)
  })
  
  
  
  selectedData <- reactive({
    cl_data[cl_data$season == input$season & cl_data$time_ >= input$radio & cl_data$time_ <= input$radio2, ]
    
  })
  
  
  output$plot2 <- renderLeaflet(
    
    {
      
      getColor <- function(data) {
        sapply(data$cluster, function(cl) {
          #if(cl == 0) {
          # "gray"
          if(cl == 1) {
            "orange"
          } else if(cl == 2) {
            "blue"
          } else if(cl == 3) {
            "green"
          } else if(cl == 4) {
            "red"
          } else if(cl == 5) {
            "white"
          } else if(cl == 6) {
            "darkblue"
          } else if(cl == 7) {
            "purple"
          } else if(cl == 8) {
            "pink"
          } else if(cl == 9) {
            "darkgreen"
          } else if(cl == 10) {
            "lightblue"
          } else if(cl == 11) {
            "lightred"
          } else if(cl == 12) {
            "lightgray"
          } else if(cl == 13) {
            "darkred"
          } else if(cl == 14) {
            "lightgreen"
          } else if(cl == 14) {
            "darkpurple"
          } else {
            "black"
          } })
      }
      
      
      icons <- awesomeIcons(
        icon = 'ios-close',
        iconColor = 'black',
        library = 'ion',
        markerColor = as.character(getColor(pp()))
      )
      
      leaflet(selectedData()) %>% addTiles() %>%
        
        addAwesomeMarkers(~lon, ~lat, icon=icons, label=~as.character(pp()$cluster))
      
    }
    
    
    
  )
  output$console <- renderText({
    print(table(pp()$cluster))
  })
  
}

#To call the application
shinyApp(ui = ui, server = server)






