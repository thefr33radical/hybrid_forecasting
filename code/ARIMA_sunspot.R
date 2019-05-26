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
data$value = apply(data[1],2,normfunc)
data$value

data

# Convert data to Time series
data = ts(data, frequency=1, start=c(1700,1),)
plot(data)

fit<- arima(data,order = c(9,0,0))
# plot model, ACf and PACF plots
tsdisplay(residuals(fit), lag.max=45, main='(9,0,0) Model Residuals')
# print output of the model
fit
summary(fit)

fcast <- forecast(fit, h=32)
# Plot the forecast model
plot(fcast)