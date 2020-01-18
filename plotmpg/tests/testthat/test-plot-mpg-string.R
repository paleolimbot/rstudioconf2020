
# currently, vdiffr requires a context
context("test-plot-mpg-string")

test_that("plot_mpg_string() works", {
  vdiffr::expect_doppelganger(
    "plot_mpg_string(), defaults",
    plot_mpg_string()
  )

  vdiffr::expect_doppelganger(
    "plot_mpg_string(), NULL colour and facet",
    plot_mpg_string(colour_var = NULL, facet_var = NULL)
  )

  vdiffr::expect_doppelganger(
    "plot_mpg_string() with colour var",
    plot_mpg_string(colour_var = "class")
  )

  vdiffr::expect_doppelganger(
    "plot_mpg_string() with facet var",
    plot_mpg_string(facet_var = "class")
  )
})
