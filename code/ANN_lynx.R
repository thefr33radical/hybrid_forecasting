library("forecast")
library(tidyverse)

# Read Data  and preprocess
data1 = read.csv("/home/alienware/workdir/github/hybrid_forecasting/data/lynx.csv")
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

# Convert data to Time series
data = ts(data, frequency=1, start=c(1821,1),)
plot(data)

# Fit the model using NNTAR and predict 14 steps
NNTAR = nnetar(window(data,end=1920),size =5,p=7,decay=0.5, maxit=150,scale.inputs=TRUE)
plot(forecast(NNTAR,h=14))
predicted = forecast(NNTAR,h=14)
predicted

# Finde MSE
pred= c()
for ( i in predicted[[16]]){
  print((i))
  pred = c(pred,i)
}
test_set = c(window(data,start=1921))
test_set
pred

print(" The MSE is ")
print(mean((pred-test_set)^2))

