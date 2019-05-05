from statsmodels.tsa.arima_model import ARIMA
from sklearn.metrics import r2_score,mean_squared_error as ms
import pandas as pd 
import numpy as np
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

def ARIMA_(split_len):

    data = pd.read_csv("~/Downloads/sunspot.csv")
    time = data["time"]
    data=data.set_index("time")
    train_data =  data.iloc[:split_len,:]
    test_data =  data.iloc[split_len:,:]

    model_arima = ARIMA(data, order=(9,0,0))
    model1 = model_arima.fit(disp=0)
    residuals1 = pd.DataFrame(model1.resid)
    residuals1.plot()
    residuals1.plot(kind='kde')
    plt.show()

    print(residuals1.describe())
    print(model1.summary())

    # one step forecast
    y_test_pred = model1.forecast()
    y_train_pred = model1.predict(start=0,end=split_len-1)
    y_test_pred = model1.predict(start=split_len,end=288)

    print("MSE Train :",ms(train_data,y_train_pred))
    print("MSE Test :",ms(test_data,y_test_pred))


    #print("The MSE score on the Train set is:\t{:0.3f}".format(ms(y_train, y_train_pred)))
    #print("The MSE score on the Test set is:\t{:0.3f}".format(ms(y_test, y_test_pred)))

# 35 test
ARIMA_(253)
# 67 test
ARIMA_(221)