'''
Utilising the fbprophet library, predictions using historical data can be made. 
This simple script will return 3 seperate charts.
'''

from fbprophet import Prophet #pip install fbprophet

import os
import pandas as pd
import numpy as np
from fbprophet import Prophet
import warnings
warnings.filterwarnings("ignore")

path_t5 = 'task_5.csv'
data_t5 = pd.read_csv(path_t5)
data_t5['ds'] = pd.to_datetime(data_t5['ds'])
data_t5.set_index('ds').plot(figsize=(12, 9))


def cast_prediction(arg_data):
    m = Prophet()
    m.fit(arg_data)
    future_data = m.make_future_dataframe(periods=365)
    forecast = m.predict(future_data)
    m.plot(forecast);

def cast_complex_prediction(arg_data):
    m = Prophet(yearly_seasonality=True)
    m.fit(arg_data)
    future_data = m.make_future_dataframe(periods=300)
    forecast = m.predict(future_data)
    m.plot(forecast)
    
    
cast_prediction(data_t5)
cast_complex_prediction(data_t5)

