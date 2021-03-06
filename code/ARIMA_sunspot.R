library(forecast)
library(ggplot2)
library(forecast)
library(tseries)
library(tidyverse)

# Read Data  and preprocess 
data = sunspot.year

# Standardardizing Values Z-score
normfunc = function(x){
  (x-mean(x,na.rm=TRUE))/(sd(x,na.rm=TRUE))
}
#data$value = apply(data[1],2,normfunc)
data

# Split into train and test set
train_set = c(window(data,end=1920))
test_set = c(window(data,start=1921,end=1987))

# -------------------------------Paper Implementation --------------------------------------------
fit<- arima(train_set,order = c(9,0,0))

# print output of the model
tsdisplay(residuals(fit), lag.max=45, main='(9,0,0) Model Residuals')
fit
summary(fit)

# Predict with confidence level 99%
predicted = forecast(fit,h=67 ,level=c(99))
plot(predicted)

# Compute residuals by ARIMA model
train_predicted = predicted[[9]]
train_predicted = c(window(train_predicted,end=1920))

test_predicted = predicted[[4]]
test_predicted = c(window(test_predicted,end=1987))

arima_predicted = append(train_predicted,test_predicted)
actual = c(window(data,start=1700,end=1987))
output_arima = abs(arima_predicted-actual)
residuals = output_arima

# Compute MSE for ARIMA model
## RMSE is 14.09? Not able to get the same by manual calc
summary(fit)
# Finde MSE

print(" The MSE is ")
print(mean((train_predicted-train_set)^2))

print(" The MSE is ")
print(mean((test_predicted-test_set)^2))




