
library(dplyr)
library(stringr)
library(readr)
library(readxl) 
library(writexl) 
library(utils)
library(RSQLite) 
library(DBI) 
library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(DT)

ruta <- "C:/Users/lopez/Documents/Prueba/Taller de programacion/practica_programada3/datos/spotify_2000_2023.csv"
datos_spotify <- read.csv2(ruta)

ui <- dashboardPage(
  skin = "green",  
  dashboardHeader(title = "Ánalisis de Spotify"),
  dashboardSidebar(
    selectInput("year", "Año:", choices = unique(datos_spotify$year)),
    selectInput("genre", "Género:", choices = unique(datos_spotify$top.genre), selected = NULL),
    column(width = 12, offset = 2,
           downloadButton("downloadDATOS", "Descargar Datos")
    )
  ),
  dashboardBody(
    skin ="green",
    box(
      status = "primary",
      solidHeader = TRUE,
      plotlyOutput("popularity_bpm_plot"),
      style = "color: white; background-color: #FFFFFF;"  
    ),
    box(
      status = "primary",
      solidHeader = TRUE,
      plotlyOutput("popularity_duration_plot"),
      style = "color: black; background-color: #FFFFFF;"   
    ),
    box(
      title = "TABLA",
      status = "primary",
      solidHeader = TRUE,
      DTOutput("filtered_table")
    )
  )
)

server <- function(input, output) {
  
  filtered_data <- reactive({
    datos_spotify |> 
      filter(year == input$year, top.genre == input$genre)
  })
  
  
  output$popularity_bpm_plot <- renderPlotly({
    ggplotly(ggplot(filtered_data(), aes(x = popularity, y = bpm, color = factor(top.genre))) +
               geom_point() +
               labs(title = "Popularidad vs BPM")
    )
  })
  
  
  output$popularity_duration_plot <- renderPlotly({
    ggplotly(ggplot(filtered_data(), aes(x = popularity, y = duration, color = factor(top.genre))) +
               geom_point() +
               labs(title = "Popularidad vs Duración de Canciones")
    )
  })
  
  
  output$filtered_table <- renderDT({
    datatable(filtered_data(), options = list(scrollX = TRUE))
  })
  
  
  output$downloadDATOS <- downloadHandler(
    filename = function() {
      paste("datos_filtrados_", input$year, "_", input$genre, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(filtered_data(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui, server)







