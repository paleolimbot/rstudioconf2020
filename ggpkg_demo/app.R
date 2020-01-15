
library(shiny)
library(ggplot2)

mpg <- ggplot2::mpg
all_vars <- colnames(mpg)
numeric_vars <- all_vars[vapply(mpg, is.numeric, logical(1))]
discrete_vars <- setdiff(all_vars, numeric_vars)

theme_set(theme_gray(9))

# Define the user interface
ui <- fluidPage(
    # these are to make the styles in the app align with the
    # styles in the presentation
    includeCSS("remark-css/default.css"),
    includeCSS("remark-css/default-fonts.css"),
    includeCSS("styles.css"),
    
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
        
        # height is an attempt to align styles to presentation
        plotOutput("plot", height = "4.5in")
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
        
    }, res = 120) # trying to replicate the settings of the presentation
}

# Run the application 
shinyApp(ui = ui, server = server)
