#residual sum of squares 
residual_sum_squares <- function(lm){
  return(sum(lm$residuals^2))
}

#total sum of squares 
total_sum_squares <- function(lm){
  return(sum(((lm$fitted.values+lm$residuals)-mean(lm$fitted.values+lm$residuals))^2))
}

#r squared 
r_squared <- function(lm){
  return(1-(residual_sum_squares(lm)/total_sum_squares(lm)))
}

#residual standard error 
residual_std_error <- function(lm){
  return(sqrt((1/((length(lm$fitted.values))-(length(lm$coefficients)-1)-1)*residual_sum_squares(lm))))
}

#f statistic 
f_statistic <- function(lm){
  TSS <- total_sum_squares(lm)
  RSS <- residual_sum_squares(lm)
  n <- length(lm$fitted.values)
  p <- length(lm$coefficients) - 1
  return(((TSS - RSS)/p)/(RSS/(n-p-1)))
}