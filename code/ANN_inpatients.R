library("forecast")
library(tidyverse)

# Read Data  and preprocess
data1 = read.csv("/home/alienware/workdir/github/hybrid_forecasting/data/inpatients.csv")
data1
data = data1
data$time=NULL
data$X=NULL

# Standardardizing Values Z-score
normfunc = function(x){
  (x-mean(x,na.rm=TRUE))/(sd(x,na.rm=TRUE))
}
data$value = apply(data[1],2,normfunc)


train_set = c(data[0:200,2])
train_set

test_set = c(data[201:224,2])
test_set

# Fit the model using NNTAR and predict 14 steps
NNTAR = nnetar(trainset,size =5,p=16,decay=0.5, maxit=150,scale.inputs=TRUE)
plot(forecast(NNTAR,h=14))
predicted = forecast(NNTAR,h=23)
predicted


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
