
# ANN Model
#!pip install statsmodels
import pandas as pd 
import numpy as np
#from google.colab import files
import io
from statsmodels.tsa.seasonal import seasonal_decompose
from matplotlib import pyplot as plt
import keras
from keras.layers import Dense
from keras.models import Sequential
from keras.optimizers import Adam
from keras.callbacks import EarlyStopping
from sklearn.metrics import r2_score,mean_squared_error as ms
from sklearn.preprocessing import MinMaxScaler

#data = files.upload()
data = pd.read_csv("~/Downloads/lynx.csv")
time = data["time"]
data=data.set_index("time")
data.plot()
plt.show()

train_data =  data.loc[:1921]
test_data =  data.loc[1921:]

x_train = train_data[:-1]
y_train = train_data[1:]

x_test = test_data[:-1]
y_test = test_data[1:]

'''scaler = MinMaxScaler(feature_range=(-1,1))
train_set = scaler.fit_transform(train_data)
test_set = scaler.fit_transform(test_data)
x_train = train_set[:-1]
y_train = train_set[1:]

x_test = test_set[:-1]
y_test = test_set[1:]
'''

print(len(x_train),len(x_test))

model_ann = Sequential()
model_ann.add(Dense(7,input_dim=1,activation="sigmoid"))
model_ann.add(Dense(5))
model_ann.add(Dense(1))

model_ann.compile(loss="mean_squared_error",optimizer="adam")
early_stop = EarlyStopping(monitor ="loss",patience =25, verbose =1)
model_ann.fit(x_train,y_train, epochs = 200, callbacks=[early_stop],batch_size=1,verbose=1,shuffle= False)


y_test_pred = model_ann.predict(x_test)
y_train_pred = model_ann.predict(x_train[:1])
print(y_train_pred,y_train)

'''y_train=scaler.inverse_transform(y_train)
y_train_pred=scaler.inverse_transform(y_train_pred)
y_test=scaler.inverse_transform(y_test)
y_test_pred=scaler.inverse_transform(y_test_pred)
print(len(y_train_pred),len(y_test_pred))
'''
#print("The MSE score on the Train set is:\t{:0.3f}".format(ms(y_train, (y_train_pred))))
#print("The MSE score on the Test set is:\t{:0.3f}".format(ms(y_test,(y_test_pred))))