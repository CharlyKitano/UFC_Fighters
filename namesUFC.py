import requests
from bs4 import BeautifulSoup
import pandas

fighter_name_list_items = []
links = []

for i in range(0, 87, 1):
    page = requests.get('https://www.ufc.com/athletes/all?filters%5B0%5D=status%3A23&page=' + str(i))
    soup = BeautifulSoup(page.text, 'html.parser')
    fighter_name_list = soup.find_all(attrs={'class':'c-listing-athlete-flipcard__action'})
    
    for item in fighter_name_list:
        fighter_name_list_items.extend(item.find_all('a'))

for item in fighter_name_list_items:
        link = 'https://www.ufc.com' + item.get('href')
        links.append(link)

df = pandas.DataFrame({'link': links})
df.to_csv("links.csv")