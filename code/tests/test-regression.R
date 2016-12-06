source("../functions/regression-functions.R")

#unit tests for functions 
context("Test for RSS")
test_that("Residual Sum of Squares Works", {
  reg <- lm(mpg ~ disp + hp, data = mtcars)
  
  expect_equal(residual_sum_squares(reg), sum(reg$residuals^2))
  
})

context("Test for TSS")
test_that("Total Sum of Squares Works", {
  reg <- lm(mpg ~ disp + hp, data = mtcars)
  
  expect_equal(total_sum_squares(reg), sum((mtcars$mpg - mean(mtcars$mpg))^2))
})

context("Test for R^2")
test_that("R-Squared Works", {
  reg <- lm(mpg ~ disp + hp, data = mtcars)
  regsum <- summary(reg)
  
  expect_equal(r_squared(reg), regsum$r.squared)
})

context("Test for RSE")
test_that("Residual Standard Error Works", {
  reg <- lm(mpg ~ disp + hp, data = mtcars)
  regsum <- summary(reg)
  
  expect_equal(residual_std_error(reg), regsum$sigma)
})

context("Test for F-Stat")
test_that("F-Statistic Works", {
  reg <- lm(mpg ~ disp + hp, data = mtcars)
  regsum <- summary(reg)
  
  expect_equal(f_statistic(reg), regsum$fstatistic[[1]])
})