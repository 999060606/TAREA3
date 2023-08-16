
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
 
    ), 
    mainPanel(
      width = 7,
      br(),
      br(),
      h3(div("¡Vamos a planificar su día especial!", style = "color:blue", align = "center")),
      tags$hr(style = "border-color:blue;"), 
      textOutput("evento_output"), 
      br(),
      tags$hr(),
      textOutput("tema_output"),
      br(),
      tags$hr(),
      textOutput("invitados_provincia_output")
    )
  )
)

server <- function(input, output) {
  output$evento_output <- renderText({
    evento <- input$nombre
    paste("Evento:", evento)
  })
  
  output$tema_output <- renderText({
    tema <- input$tema
    paste("Tema del Evento:", tema)
  })
  
  output$invitados_provincia_output <- renderText({
    tema <- input$tema
    invitados <- input$invitados
    provincia <- input$provincia
    paste("Número de invitados y ubicación: El evento '", tema, "' tendrá ", invitados, " invitados y será llevado a cabo en ", provincia, ".")
  })
}

shinyApp(ui, server)

    
    
