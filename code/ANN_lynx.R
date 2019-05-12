library("forecast")
library(tidyverse)

data1 = read.csv("/home/alienware/workdir/github/hybrid_forecasting/data/lynx.csv")
data1
data = data1


normfunc = function(x){
  
  (x-mean(x,na.rm=TRUE))/(sd(x,na.rm=TRUE))
}
data$time=NULL
data$X=NULL

data$value = apply(data[1],2,normfunc)
data$value
data = ts(data, frequency=1, start=c(1821,1),)
plot(data)

NNTAR = nnetar(window(data,end=1920),size =5,p=7,decay=0.5, maxit=150,scale.inputs=TRUE)
plot(forecast(NNTAR,h=14))
predicted = forecast(NNTAR,h=14)
predicted

pred= c()
for ( i in predicted[[16]]){
  print((i))
  pred = c(pred,i)
}
test_set = c(window(data,start=1921))
test_set
pred
length(pred)
length(test_set)
mean((pred-test_set)^2)
data
