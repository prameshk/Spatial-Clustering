#You need to load the shiny library to run the app
library(shiny)

# this is for converting data frame into data table, idk but it works
require(data.table)
library(leaflet)
#Test is the name of the file with trip chaining results
library(ggmap)
#here you write your User Interface for your app. Note that some of the fields are decided by uioutput
ui <- fluidPage(
  pageWithSidebar(
    #Name of the header panel
    headerPanel('Daily Origin Clustering', windowTitle = "Daily Origin Clustering"),
    # These options (dropdown menus) will come in the sidebar.
    sidebarPanel(
      textInput("dat1", "Please enter the start date", '2016-03-07'),
      textInput("dat2", "Please enter the end date", '2016-03-07')),
    mainPanel(
      #This is important for plotting frame
      leafletOutput('plot2', height = 1000, width = 1000)
      
    )
  )
)

server <- function(input, output, session) {
  library(RPostgreSQL)
  
  source("keys.R")
  #call_service(id, pw, ...)

  
  drv <- dbDriver("PostgreSQL")
  
  # This will connect to the databes that user selects form dropdown menu.
  con <- reactive({dbConnect(drv, dbname = db,
                             host = host, port = port,
                             user = id, password = pw)})
  
  destination_data <- reactive({
    sqlInput <- paste0("select a.*, row_number() over (partition by serial_nbr, date_ order by time_) as seqnum from dta.afc_test a where date_ >= '", input$dat1 , "' and date_ <= '", input$dat1, "' order by  serial_nbr, date_, time_")
    #sqlInput <- paste0("select a.*, row_number() over (partition by serial_nbr, date_ order by time_) as seqnum
                   #from dta.afc_test a where date_ >= '2016-03-07' and date_ <= '2016-03-07' order by  serial_nbr, date_, time_")
    dbGetQuery(con(), sqlInput)
    
  })
  

  output$plot2 <- renderLeaflet(
    {
      leaflet() %>%
        addTiles() %>% 
        setView(lng = -93.227729, lat = 44.973990, zoom = 13) %>%
        addMarkers(lat = as.numeric(destination_data()$lat), 
                   lng = as.numeric(destination_data()$lon),
                   clusterOptions = markerClusterOptions()
                   
        )
      
    }
  )

}


shinyApp(ui = ui, server = server)
