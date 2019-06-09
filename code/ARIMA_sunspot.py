from statsmodels.tsa.arima_model import ARIMA
from sklearn.metrics import r2_score,mean_squared_error as ms
import pandas as pd 
import numpy as np
import io
from statsmodels.tsa.seasonal import seasonal_decompose
from matplotlib import pyplot as plt
from sklearn.metrics import r2_score,mean_squared_error as ms


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
    #plt.show()

    print(residuals1.describe())
    print(model1.summary())

    results_train =[]
    results_pred =[]
    #temp =model1.predict(start=0,end=1)

    forecast = model1.predict(start=start_index, end=end_index)
    print(forecast,train_data[:100])
    # one step forecastvalue"
   
    errr

    #print("MSE Train :",ms(train_data,y_train_pred))
    #print("MSE Test :",ms(test_data,y_test_pred))
    #print("The MSE score on the Train set is:\t{:0.3f}".format(ms(y_train, y_train_pred)))
    #print("The MSE score on the Test set is:\t{:0.3f}".format(ms(y_test, y_test_pred)))

# 35 test
ARIMA_(253)
# 67 test
#ARIMA_(221)