'''
This Python script uses the Google Maps API to retrieve the distance and 
current time it would take to reach both the Sunshine Coast and the Gold Coast from the Brisbane CBD.
Some modules will need to be manually installed before this script will work.
'''

import googlemaps #pip install GoogleMaps
from datetime import datetime # import datetime module to retrieve current time
from tabulate import tabulate #pip install tabulate      ###for presenting the results in a tableau layout

def travelspecs():
    gmaps = googlemaps.Client(key='AIzaSyC4Zr-roMrneExsLek0B0yiB5woxMg1Ds0') #API Key 


    now = datetime.now()
    directions_result_sunshine = gmaps.directions("-27.466047, 153.024767",   #Coordinates of Brisbane to the Sunshine Coast
                                            "-26.644879, 153.069303",
                                             mode="driving",
                                             departure_time=now       #Estimation based on if you left now
                                            )

    dis_sunshine=(directions_result_sunshine[0]['legs'][0]['distance']['text']) #setting the result to a variable
    dur_sunshine =(directions_result_sunshine[0]['legs'][0]['duration']['text']) #setting the result to a variable
    

    now = datetime.now()
    directions_result_goldcoast = gmaps.directions("-27.466047, 153.024767",    #Coordinates of Brisbane to the Gold Coast
                                            "-28.000592, 153.430684",
                                             mode="driving",
                                             departure_time=now   #Estimation based on if you left now
                                            )
    dis_goldcoast=(directions_result_goldcoast[0]['legs'][0]['distance']['text']) #setting the result to a variable
    dur_goldcoast=(directions_result_goldcoast[0]['legs'][0]['duration']['text']) #setting the result to a variable

    table = [["","Distance","Duration"],["Sunshine Coast",dis_sunshine,dur_sunshine],  #setting up rows/columns of table using the assigned variables
         ["Gold Coast",dis_goldcoast,dur_goldcoast]]
    
    print("Using the Google Maps API, we can calculate the distance and current time it would take to travel from the Brisbane CBD to either locations.")
    print(tabulate(table))  #print results in tableau format


travelspecs() #call function
