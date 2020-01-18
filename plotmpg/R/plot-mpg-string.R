
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
#' plot_mpg_string("class", "manufacturer")
#'
#' @importFrom ggplot2 ggplot aes vars facet_wrap geom_point labs
#' @importFrom rlang .data sym
plot_mpg_string <- function(colour_var = NULL, facet_var = NULL) {
  if (!is.null(colour_var)) {
    colour_mapping <- sym(colour_var)
  } else {
    colour_mapping <- NULL
  }

  if (!is.null(facet_var)) {
    facet <- facet_wrap(vars(!!sym(facet_var)))
  } else {
    facet <- NULL
  }

  ggplot(ggplot2::mpg) +
    geom_point(aes(.data$displ, .data$hwy, colour = !!colour_mapping)) +
    facet +
    labs(x = "displ", y = "hwy")
}
