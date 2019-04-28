# R Script to deseasonalize Australian gas company dataset in R and use ARIMA model for forecasting.

# Function to load data
library(forecast)
library('ggplot2')
library('forecast')
library('tseries')

get_data <- function()
{ 
    data <- gas
  data = ts(data, frequency=12, start=c(1950,1))
  plot(gas)
  # Print timeseries data
 return(data)
}

# Function to decompose the time series into seasonal, trend,noise
automated_decomposer = function(data)
{
  # decompose time series using addtive model 
  decomposed = decompose(data, "additive")
  # plot seasonal component of decomposed data
  plot(as.ts(decomposed$seasonal))
  # plot trend component of decomposed data
  plot(as.ts(decomposed$trend))
  # plot noise component of decomposed data
  plot(as.ts(decomposed$random))
  # plot all component of decomposed data
  plot(decomposed)
  # print decomposed data
  decomposed
  # remove the seasonal component
  season_adj <- data - decomposed$seasonal
  # plot the deseasonalized data
  plot.ts(season_adj)
 return(season_adj)
  
}

data=get_data()
data=automated_decomposer(data)


# Computing the augumentedd dickey fuller test
adf.test(data ,alternative = "stationary")
# Use auto correlation function to check for variable and lags
Acf(data, main='acf')
# Use auto correlation function to check for variable and lags that is not explained by previous lags
Pacf(data ,main='pacf')

# use auto ARIMA model to fit data
fit<-auto.arima(data, seasonal=FALSE)
# plot model, ACf and PACF plots
tsdisplay(residuals(fit), lag.max=45, main='(1,1,1) Model Residuals')
# print output of the model
fit
# Forecast using fitted model
fcast <- forecast(fit, h=30)
# Plot the forecast model
plot(fcast)
