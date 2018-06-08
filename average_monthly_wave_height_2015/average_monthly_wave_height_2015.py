'''
This Python script takes a csv file containing tens of thousands of 
rows of wave height (ft) data from the Sunshine Coast and plots the monthly averages, over the year 2015.
'''

import pandas as pd
import numpy as np
import csv
import pandas as pd

# Set variables for file and index column
file3 = 'SC_WAVE_2015.csv' #see above
colname3 = 'Date/Time' #open the csv and have a look

# Read in the gold coast wave data to a variable
SC_2015_wave_height = pd.read_csv(file3, index_col= colname3)
#print(SC_2015_wave_height.shape) #check the correct amount of rows/columns are showing up

wavedata3=pd.read_csv("SC_WAVE_2015.csv") #assign the data file to a new variable
keep_columns3 = ['Date/Time','Hs'] #specify which columns I wish to keep
new_wavedata3 = wavedata3[keep_columns3] 
new_wavedata3.to_csv("SC_WAVE_2015_NEW.csv", index=False) #create a new csv file with modified columns
                
with open('SC_WAVE_2015_NEW.csv', 'r') as f_in: #read from 
    with open('SC_WAVE_2015_NEW1.csv', 'w') as f_outfile: #write to
        f_out = csv.writer(f_outfile, escapechar=' ',quoting=csv.QUOTE_NONE)

        for line in f_in:
            line = line.strip()
            row = [] 
            if '08:00' in line: #for the row that contains that particular string, append the line to the csv file - filtering the rest
                row.append(line)
                f_out.writerow(row)

SC_2015_df = pd.read_csv('SC_WAVE_2015_NEW1.csv', sep = ',',header = None) 
SC_2015_df.columns = ['Date', 'Average Wave Height'] #add column headers
SC_2015_df.to_csv('SC_WAVE_2015_NEW1.csv', index=False)


MEAN_SC_2015_df=SC_2015_df.groupby(np.arange(len(SC_2015_df.index))//31).mean()
#newdf=newdf[:-1]
MEAN_SC_2015_df  #Monthly mean of Sunshine Coast 2015 wave heights


import matplotlib.pyplot as plt

plt.plot(MEAN_SC_2015_df, 'g-', label='Sunshine Coast')
plt.ylabel('Wave Height (ft)') #y axis label
plt.xlabel('\nMonth of Year') #x axis label
plt.title('Sunshine Coast Wave Height Average for Each Month for Year 2015') #bar chart title
plt.legend(loc='upper right')
plt.ylim(ymin=0.6) # start y-axis at 0.6 ft   
plt.show()
