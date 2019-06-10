import pandas as pd
import re
import operator
from functools import reduce
import datetime
data = pd.read_excel("/home/user/workdir/thefr33radical/hybrid_forecasting/data/Data.xls")
date="Date."
week="Week."
number="Number ."

full_date=[]
full_week=[]
full_number=[]

full_date.append(data["Date"])
full_week.append(data["Week"])
full_number.append(data["Number "])

for i in range(1,4):
    full_date.append(data[date+str(i)])
    full_week.append(data[week+str(i)])
    full_number.append(data[number+str(i)])
#full_date=reduce(operator.concat, full_date)
#print(full_number)

def load_no(full_number):
        
    comp_no=[]
    for dat in full_number:
        for k in dat:
            comp_no.append(k)
    return comp_no

def load_date(full_date):
    comp_date=[]
    for dat in full_date:
        for k in dat:
            comp_date.append(k)
    return comp_date

#print(data["Unnamed: 3"][1])

dataset = pd.DataFrame()
dataset["date"]=load_date(full_date)
dataset["num"]=load_no(full_number)

#dt= datetime.date()
#print(dataset)

dataset.to_csv("/home/user/workdir/thefr33radical/hybrid_forecasting/parsed_inpatients.csv",sep=",",header=True)
