library(forecast)
library(ggplot2)
library(forecast)
library(tseries)
library(tidyverse)

# Read Data  and preprocess
data1=lynx
data = data1

# Standardardizing Values Z-score
normfunc = function(x){
  (x-mean(x,na.rm=TRUE))/(sd(x,na.rm=TRUE))
}
#data$value = apply(data[1],2,normfunc)
data

train_set = c(window(data,end=1920))
train_set

test_set = c(window(data,start=1921,end=1934))
test_set

fit<- arima(train_set,order = c(12,0,0))
# plot model, ACf and PACF plots
tsdisplay(residuals(fit), lag.max=45, main='(12,0,0) Model Residuals')
# print output of the model
fit
summary(fit)

predicted = forecast(fit,h=14, level=c(95))
plot(predicted)
predicted
test_set

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

# pass the result set to ANN
result_set=c()
for ( i in pred){
  result_set = c(abs(pred-test_set),i)
}


#END------------------------------------AutoArima-------------------------------------------------
fit2<-auto.arima(train_set, seasonal=FALSE)
# plot model, ACf and PACF plots
tsdisplay(residuals(fit2), lag.max=45, main='(1,1,1) Model Residuals')
# print output of the model
fit2
summary(fit2)

fcast <- forecast(fit, h=32)
# Plot the forecast model
plot(fcast)