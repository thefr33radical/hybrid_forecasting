library(forecast)
library(ggplot2)
library(forecast)
library(tseries)
#library(tidyverse)

# Read Data  and preprocess

data = read.csv(file.choose())

# Standardardizing Values Z-score
normfunc = function(x){
  (x-mean(x,na.rm=TRUE))/(sd(x,na.rm=TRUE))
}
#data$value = apply(data[1],2,normfunc)
data2=data$num
data2

train_set = c(data[0:200,2])
train_set

test_set = c(data[201:224,2])
test_set

fit<- arima(train_set,order = c(1,1,0))
# plot model, ACf and PACF plots
tsdisplay(residuals(fit), lag.max=45, main='(12,0,0) Model Residuals')
# print output of the model
fit
summary(fit)

predicted = forecast(fit,h=23, level=c(95))
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
