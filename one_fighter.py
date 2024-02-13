import requests
from bs4 import BeautifulSoup
import pandas as pd

# URL de la page du combattant
url = 'https://www.ufc.com/athlete/israel-adesanya'

# Effectuer la requête HTTP pour obtenir le contenu de la page
response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

# Initialiser le dictionnaire principal pour recueillir toutes les données
fighter_data = {}

# Nom du combattant
fighter_name = soup.find('h1', class_='hero-profile__name')
fighter_data['Name'] = fighter_name.get_text(strip=True) if fighter_name else 'N/A'

# Fonction pour extraire et traiter les blocs de statistiques
def process_stat_blocks(soup, data_key, class_name, data_dict):
    elements = soup.find_all('div', class_=class_name)
    for element in elements:
        label_element = element.find('div', class_='c-stat-compare__label')
        value_element = element.find('div', class_='c-stat-compare__number')
        label = label_element.get_text(strip=True) if label_element else 'Unknown'
        value = value_element.get_text(strip=True) if value_element else '0'
        data_dict[f"{data_key} - {label}"] = value

# Extraire des informations sur les statistiques de combat
process_stat_blocks(soup, "Stats", "c-stat-compare__group", fighter_data)

# Extraction des données personnelles et ajout au dictionnaire fighter_data
fields = soup.find_all('div', class_='c-bio__field')
label_mapping = {
    'Lieu de naissance': 'Birthplace',
    'Âge': 'Age',
    'La Taille': 'Height',
    'Poids': 'Weight',
    'Reach': 'Reach',
    'Portée de la jambe': 'Leg Reach'
}
for field in fields:
    label = field.find('div', class_='c-bio__label').get_text(strip=True)
    text = field.find('div', class_='c-bio__text')
    mapped_label = label_mapping.get(label)
    if mapped_label:
        fighter_data[mapped_label] = text.get_text(strip=True) if text else '0'

# Convertir le dictionnaire final en DataFrame
df_final = pd.DataFrame([fighter_data])


