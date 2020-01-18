
# currently, vdiffr requires a context
context("test-plot-mpg")

test_that("plot_mpg() works", {
  vdiffr::expect_doppelganger(
    "plot_mpg(), defaults",
    plot_mpg()
  )

  vdiffr::expect_doppelganger(
    "plot_mpg(), NULL colour and facet",
    plot_mpg(colour_var = NULL, facet_var = NULL)
  )

  vdiffr::expect_doppelganger(
    "plot_mpg() with colour var",
    plot_mpg(colour_var = class)
  )

  vdiffr::expect_doppelganger(
    "plot_mpg() with facet var",
    plot_mpg(facet_var = class)
  )
})
