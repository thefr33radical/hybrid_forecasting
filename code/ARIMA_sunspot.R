  library(forecast)
  library(ggplot2)
  library(forecast)
  library(tseries)
  
  
  library("forecast")
  library(tidyverse)
  
  # Read Data  and preprocess
  data1 = read.csv("/home/user/workdir/thefr33radical/hybrid_forecasting/data/sunspot.year.csv")
  data1
  data = data1
  data$time=NULL
  data$X=NULL
  
  # Standardardizing Values Z-score
  normfunc = function(x){
    (x-mean(x,na.rm=TRUE))/(sd(x,na.rm=TRUE))
  }
  #data$value = apply(data[1],2,normfunc)
  data$value
  data
  
  # Convert data to Time series
  data = ts(data, frequency=1, start=c(1700,1),)
  plot(data)
  
  train_set = c(window(data,end=1956))
  train_set
  
  test_set = c(window(data,start=1957))
  test_set

fit<- arima(train_set,order = c(9,0,0))
# plot model, ACf and PACF plots
tsdisplay(residuals(fit), lag.max=45, main='(9,0,0) Model Residuals')
# print output of the model
fit
summary(fit)

predicted = forecast(fit,h=32)
plot(predicted)
predicted

predicted[[4]]
# Finde MSE
pred= c()
for ( i in predicted[[4]]){
  print((i))
  pred = c(pred,i)
}

pred
test_set

print(" The MSE is ")
print(mean((pred-test_set)^2))


# -------------------------------AUTO ARIMA------------------------------------------
fit2<- auto.arima(train_set,d=9)
predicted2 = forecast(fit2,h=32)
plot(predicted2)
predicted2

summary(fit2)

predicted2[[4]]
# Finde MSE
pred2= c()
for ( i in predicted2[[4]]){
  print((i))
  pred2 = c(pred2,i)
}
pred2

print(" The MSE is ")
print(sum((pred2-test_set)^2)/length(pred))

predicted3 = predict(fit, 32)
predicted3 
pred3= c()
for ( i in predicted3){
  print((i))
  pred3 = c(pred3,i)
}
pred3
print(" The MSE is ")
print(sum((pred3-test_set)^2)/length(pred3))
