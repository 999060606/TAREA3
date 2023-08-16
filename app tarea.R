
library(shiny)

ui <- fluidPage(
  titlePanel("Planificador de eventos"),
  
  sidebarLayout(
    sidebarPanel( 
      width = 4,
      br(),
      textInput(inputId = "nombre", 
                label = "Nombre del evento:"),
      br(),
      selectInput(inputId = "tema",    
                  label = "Tema del evento:", 
                  choices = c("Boda", "Fiesta de Cumpleaños", "Conferencia", "Otro"),
                  multiple = FALSE),
      
      numericInput(inputId = "invitados",
                   label = "Número de invitados:", 
                   value = 58, 
                   min = 25,
                   max = 120),
      
      selectInput(inputId = "provincia",
                  label = "Seleccione la provincia en la que vive:",
                  choices = c("San José", "Heredia", "Cartago", "Limón", "Puntarenas", "Alajuela"),
                  multiple = FALSE)
 

