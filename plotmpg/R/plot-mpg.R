
#' Plot the mpg dataset
#'
#' @param colour_var A variable or expression to use as a
#' [mapping][ggplot2::aes] for the colour aesthetic,
#' or `NULL` to suppress.
#' @param facet_var A variable or expression to use in
#' [ggplot2::facet_wrap()], or `NULL` to skip facetting.
#'
#' @return A [ggplot2::ggplot()] object.
#' @export
#'
#' @examples
#' plot_mpg(class, manufacturer)
#'
#' @importFrom ggplot2 ggplot aes vars facet_wrap geom_point labs
#' @importFrom rlang .data enquo quo_is_null
plot_mpg <- function(colour_var = NULL, facet_var = NULL) {
  facet_quo <- enquo(facet_var)
  if (!quo_is_null(facet_quo)) {
    facet <- facet_wrap(vars(!!facet_quo))
  } else {
    facet <- NULL
  }

  ggplot(ggplot2::mpg) +
    geom_point(aes(.data$displ, .data$hwy, colour = {{ colour_var }})) +
    facet +
    labs(x = "displ", y = "hwy")
}
