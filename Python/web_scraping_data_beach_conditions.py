'''
This Python script web-scrapes data from a popular surfing website. In this example it will retrieve the current wave
height and weather conditions of both the Sunshine Coast and Gold Coast beaches.
'''

from bs4 import BeautifulSoup   #pip install bs4
import urllib.request

def get_HTML(url): #function that takes a website url, reads and then returns the raw HTML
    response = urllib.request.urlopen(url)
    html = response.read()
    return html

SC_wavedata = get_HTML('https://magicseaweed.com/Sunshine-Beach-Surf-Report/1004/') #set sunshine coast url html to a variable
GC_wavedata = get_HTML('https://magicseaweed.com/Surfers-Paradise-Gold-Coast-Surf-Report/1012/') #set gold coast url html to a variable


def currentwave():
       
    GC_soup = BeautifulSoup(GC_wavedata, "lxml")  #assign variable to BeautifulSoup parameters

    for element in GC_soup(attrs={'class' : 'rating-text text-dark'}):   #look for the class with the corresponding value
        print("The current wave conditions at the Gold Coast are: {}.".format(element.text.strip()))  #print the text after the matching class & value
        
    for element in GC_soup(attrs={'class' : 'weather-icon weather-icon-10'}):   #look for the class with the corresponding value
        if element.text not in GC_soup:   #only add once / prevent dupplicates
            GC_soup.append(element.text.strip())
            print("The current weather conditions at the Gold Coast are: {}.".format(element.text.strip()))   #print the text after the matching class & value
      
    print() # free line space
    
    SC_soup = BeautifulSoup(SC_wavedata, "lxml")  #assign variable to BeautifulSoup parameters

    for element in SC_soup(attrs={'class' : 'rating-text text-dark'}):   #look for the class with the corresponding value
        print("The current wave conditions at the Sunshine Coast are: {}.".format(element.text.strip()))   #print the text after the matching class & value
    
    for element in SC_soup(attrs={'class' : 'weather-icon weather-icon-10'}):   #look for the class with the corresponding value
        if element.text not in SC_soup:   #only add once / prevent dupplicates
            SC_soup.append(element.text.strip())
            print("The current weather conditions at the Sunshine Coast are: {}.".format(element.text.strip()))  #print the text after the matching class & value
      

currentwave()  #call function
