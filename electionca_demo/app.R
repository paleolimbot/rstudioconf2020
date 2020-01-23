
library(shiny)
library(ggplot2)
library(electionca)

# ---- define Shiny app ----

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
                "fill_var",
                "Fill Variable",
                choices = c("<none>", "party"),
                selected = "party"
            ),
            selectInput(
                "facet_var",
                "Facet Variable",
                choices = c("<none>", "party", "province"),
                selected = "<none>"
            ),
            selectInput(
                "position",
                "Stack or fill",
                choices = c("stack", "fill"),
                selected = "stack"
            )
        ),
        
        # height is an attempt to align styles to presentation
        plotOutput("plot", height = "4.5in")
    )
)

# Define server logic
server <- function(input, output) {

    output$plot <- renderPlot({
        fill_var <- if (input$fill_var != "<none>") input$fill_var
        facet_var <- if (input$facet_var != "<none>") input$facet_var
        
        plot_votes(
            years = 2006:2019,
            fill_var = fill_var,
            facet_var = facet_var,
            position = input$position
        ) +
            theme(legend.position = "right")
    }, res = 120) # trying to replicate the settings of the presentation
}

# ---- run Shiny app ----

# Run the application 
shinyApp(ui = ui, server = server)
