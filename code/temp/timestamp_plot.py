import pandas as pd
import json
import datetime
from dateutil.parser import parse
import matplotlib.pyplot as plt

def load_data(path_file):
    """

	Function to convert the TBHP data to time series and plot
    """
    with open(path_file,"r+") as f:
        data = json.loads(f.read())
        dataset = pd.DataFrame(data)

        datetime =[]

        for i in range(len(dataset)):
            datetime.append(parse(dataset["timestamp"][i]))

        dataset["timestamp"] = datetime
        del(dataset["title"])
        del (dataset["text"])
        del (dataset["username"])
        del (dataset['post_type'])


        dataset["timestamp"] = pd.to_datetime(dataset["timestamp"])
        dataset.index = dataset["timestamp"]
        del( dataset["timestamp"] )
        
        dataset.plot(subplots=True,y=["avg_word_length", "no_of_words","avg_sentence_length"], figsize=(15, 4))
        plt.show()
        #df.plot(x="R", y=["F10.7", "Dst"], style='.')

path= ""
load_data(path)
