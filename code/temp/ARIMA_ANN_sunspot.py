from statsmodels.tsa.arima_model import ARIMA
from sklearn.metrics import r2_score,mean_squared_error as ms
import pandas as pd 
import numpy as np
from statsmodels.tsa.seasonal import seasonal_decompose
from matplotlib import pyplot as plt
import keras
from keras.layers import Dense
from keras.models import Sequential
from keras.optimizers import Adam
from keras.callbacks import EarlyStopping
from sklearn.preprocessing import MinMaxScaler

def ARIMA_(split_len):

    data = pd.read_csv("~/Downloads/sunspot.csv")
    time = data["time"]
    data = data.set_index("time")
    train_data =  data.iloc[:split_len,:]
    test_data =  data.iloc[split_len:,:]

    model_arima = ARIMA(data, order=(9,0,0))
    model1 = model_arima.fit(disp=0)
    residuals1 = pd.DataFrame(model1.resid)
    residuals1.plot()
    residuals1.plot(kind='kde')
    #plt.show()

    #print(residuals1.describe())
    #print(model1.summary())

    y_train_pred = model1.predict(start=0,end=split_len-1)
    y_test_pred = model1.predict(start=split_len,end=288)
    y_actual = np.array(data["value"])
    
    error_train = y_actual[:split_len]  - np.array(y_train_pred)
    error_test = y_actual[split_len:] - y_test_pred
    # one step forecastvalue"
    print("MSE Train :",ms(train_data,y_train_pred))
    print("MSE Test :",ms(test_data,y_test_pred))

    #print(len(error_train),len(y_train_pred))
    
    return error_train,error_test, data


def ANN(error_train,error_test,data, split_len):
    train_data =  data.iloc[:split_len,:]
    test_data =  data.iloc[split_len:,:]


    x_train = error_train[1:]
   
    y_train = train_data[1:]

    x_test = error_test[1:]
   
    y_test = test_data[1:]

    model_ann = Sequential()
    model_ann.add(Dense(4,input_dim=1,activation="sigmoid"))
    model_ann.add(Dense(4))
    model_ann.add(Dense(1))

    model_ann.compile(loss="mean_squared_error",optimizer="adam")
    early_stop = EarlyStopping(monitor ="loss",patience =25, verbose =1)
    model_ann.fit(x_train,y_train, epochs = 200, callbacks=[early_stop],batch_size=10,verbose=1,shuffle= False)

    y_test_pred = model_ann.predict(x_test)
    y_train_pred = model_ann.predict(x_train)

    print("The MSE score on the Train set is:\t{:0.3f}".format(ms(y_train, (y_train_pred))))
    print("The MSE score on the Test set is:\t{:0.3f}".format(ms(y_test,(y_test_pred))))

    # 35 test
error_train,error_test,data = ARIMA_(253)
ANN(error_train,error_test,data,253)

    # 67 test
    #ARIMA_(221)