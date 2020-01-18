
library(shiny)
library(ggplot2)

# ---- load data ----

mpg <- ggplot2::mpg
all_vars <- colnames(mpg)
numeric_vars <- all_vars[vapply(mpg, is.numeric, logical(1))]
discrete_vars <- setdiff(all_vars, numeric_vars)

theme_set(theme_gray(9))

# function that takes plot options as strings
plot_mpg_string <- function(colour_var, facet_var) {
    if (colour_var != "<none>") {
        colour_mapping <- sym(colour_var)
    } else {
        colour_mapping <- NULL
    }
    
    if (facet_var != "<none>") {
        facet <- facet_wrap(vars(!!sym(facet_var)))
    } else {
        facet <- NULL
    }
    
    ggplot(mpg) +
        geom_point(aes(displ, hwy, colour = !!colour_mapping)) +
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
        plot_mpg_string(input$colour_var, input$facet_var)
    }, res = 120) # trying to replicate the settings of the presentation
}

# ---- run Shiny app ----

# Run the application 
shinyApp(ui = ui, server = server)
