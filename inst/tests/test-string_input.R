context("string input")

test_that("state level choropleths handle string input", {
  df = data.frame(region=state.abb, value=c("a", "b"))
  df$value = as.character(df$value)
  expect_is(choroplethr(df, lod="state"), "ggplot")
})

data(county.names, package="choroplethr")
test_that("county level choropleths handle string input", {
  df = data.frame(region=county.names$county.fips.character, value=c("a", "b"))
  df$value = as.character(df$value)
  expect_is(choroplethr(df, lod="county", warn_na=FALSE), "ggplot")
})

data(zipcode, package="zipcode")
test_that("zip level maps handle string input", {
  df = data.frame(region=zipcode$zip, value = c("a", "b"))
  df$value = as.character(df$value)
  expect_is(choroplethr(df, lod="zip"), "ggplot")
})
