
library(shiny)
library(ggplot2)

mpg <- ggplot2::mpg
all_vars <- colnames(mpg)
numeric_vars <- all_vars[vapply(mpg, is.numeric, logical(1))]
discrete_vars <- setdiff(all_vars, numeric_vars)

# Define the user interface
ui <- fluidPage(
    
    verticalLayout(
        
        inputPanel(
            selectInput(
                "colour_var",
                "Colour Variable",
                choices = c("<none>", all_vars),
                selected = "class"
            ),
            selectInput(
                "facet_var",
                "Facet Variable",
                choices = c("<none>", discrete_vars),
                selected = "manufacturer"
                
            )
        ),

        plotOutput("plot")
    )
)

# Define server logic
server <- function(input, output) {

    output$plot <- renderPlot({
        if (input$facet_var != "<none>") {
            facet <- facet_wrap(vars(.data[[input$facet_var]]))
        } else {
            facet <- NULL
        }
        
        if (input$colour_var != "<none>") {
            mapping <- aes(colour = .data[[input$colour_var]])
        } else {
            mapping <- NULL
        }
        
        ggplot(mpg, aes(displ, hwy)) +
            geom_point(mapping) +
            facet +
            labs(colour = input$colour_var)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
