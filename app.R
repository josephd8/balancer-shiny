
library(shiny)
source("helpers.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Balancer Pools"),

    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = 'type',
                        label = 'Pool Type',
                        choices = c("Smart", "Shared", "Private"),
                        selected = 1),
            uiOutput("pool_selection")

        ),

        mainPanel(
            textOutput("pool_stats")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    ref <- reactive({
        if(input$type == "Smart"){
            return(smart)
        } else if (input$type == "Shared"){
            return(shared)
        } else if (input$type == "Private"){
            return(private)
        }
    })
    
    output$pool_selection <- renderUI({
        selectInput(inputId = "pool",
                    label = "Pool", 
                    choices = get_pool_names(ref()),
                    selected = 1)
    })
    
    stats <- reactive({
        get_pool_stats(ref(), input$pool)
    })
    
    output$pool_stats <- renderText(
        get_pool_stats(ref(), input$pool)
    )

}

# Run the application 
shinyApp(ui = ui, server = server)
