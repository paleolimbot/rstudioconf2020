
library(shiny)
library(ggplot2)

# ---- load data ----

mpg <- ggplot2::mpg
all_vars <- colnames(mpg)
numeric_vars <- all_vars[vapply(mpg, is.numeric, logical(1))]
discrete_vars <- setdiff(all_vars, numeric_vars)

theme_set(theme_gray(9))

plot_mpg <- function(colour_var, facet_var) {
    mapping <- aes(displ, hwy, colour = .data[[colour_var]])
    
    if (is.null(colour_var)) {
        mapping$colour <- NULL
    }
    
    if (is.null(facet_var)) {
        facet <- NULL
    } else {
        facet <- facet_wrap(vars(.data[[facet_var]]))
    }
    
    ggplot(mpg) +
        geom_point(mapping) +
        facet
}

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
        if (input$colour_var == "<none>") {
            colour_var <- NULL
        } else {
            colour_var <- input$colour_var
        }
        
        if (input$facet_var == "<none>") {
            facet_var <- NULL
        } else {
            facet_var <- input$facet_var
        }
        
        plot_mpg(colour_var, facet_var)
    }, res = 120) # trying to replicate the settings of the presentation
}

# ---- run Shiny app ----

# Run the application 
shinyApp(ui = ui, server = server)
