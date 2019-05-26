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

# Convert data to Time series
data = ts(data, frequency=1, start=c(1700,1),)
plot(data)

# Fit the model using NNTAR and predict 14 steps
NNTAR = nnetar(window(data,end=1953),size =4,p=4,decay=0.5, maxit=150,scale.inputs=TRUE)
plot(forecast(NNTAR,h=32))
predicted = forecast(NNTAR,h=32)
predicted
plot(predicted)
summary(NNTAR)
# Finde MSE
pred= c()
for ( i in predicted[[16]]){
  print((i))
  pred = c(pred,i)
}
test_set = c(window(data,start=1953))
test_set
pred

print(" The MSE is ")
print(mean((pred-test_set)^2))

