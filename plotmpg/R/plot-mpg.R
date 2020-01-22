
#' Plot the mpg dataset using string variable specification
#'
#' @param colour_var A variable name as a string to use as a
#' [mapping][ggplot2::aes] for the colour aesthetic,
#' or `NULL` to suppress.
#' @param facet_var A variable name as a string to use in
#' [ggplot2::facet_wrap()], or `NULL` to skip facetting.
#'
#' @return A [ggplot2::ggplot()] object.
#' @export
#'
#' @examples
#' plot_mpg("class", "manufacturer")
#'
#' @importFrom ggplot2 ggplot aes vars facet_wrap geom_point labs
#' @importFrom rlang .data sym
plot_mpg <- function(colour_var = NULL, facet_var = NULL) {
  mapping <- aes(.data$displ, .data$hwy, colour = .data[[colour_var]])

  if (is.null(colour_var)) {
    mapping$colour <- NULL
  }

  if (is.null(facet_var)) {
    facet <- NULL
  } else {
    facet <- facet_wrap(vars(.data[[facet_var]]))
  }

  ggplot(ggplot2::mpg) +
    geom_point(mapping) +
    facet
}
