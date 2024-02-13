import requests
from bs4 import BeautifulSoup
import pandas as pd

# Liste pour stocker les données de tous les combattants
donnees_combattants = []
chemin_csv = 'C:/Users/tmore/Desktop/VS Code/projet/infos.csv'

for i in range(0, 87, 1):
    page = requests.get('https://www.ufc.com/athletes/all?filters%5B0%5D=status%3A23&page=' + str(i))
    soup = BeautifulSoup(page.text, 'html.parser')
    fighter_name_list = soup.find_all(attrs={'class':'c-listing-athlete-flipcard__action'})
    
    for item in fighter_name_list:
        # Liste pour stocker les données de chaque combattant
        donnees_combattant = []
        
        link = 'https://www.ufc.com' + item.find('a').get('href')
        
        # Effectuer la requête HTTP pour obtenir le contenu de la page du combattant
        response = requests.get(link)
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Nom du combattant
        fighter_name = soup.find('h1', class_='hero-profile__name').get_text(strip=True) if soup.find('h1', class_='hero-profile__name') else 'N/A'
        donnees_combattant.append(fighter_name)

        # Fonction pour extraire et traiter les blocs de statistiques
        def process_stat_blocks(soup):
            stats_blocks = soup.find_all('div', class_='c-stat-3bar c-stat-3bar--no-chart')
            for block in stats_blocks:
                title = block.find('h2', class_='c-stat-3bar__title').text.strip()
                stat_groups = block.find_all('div', class_='c-stat-3bar__group')
                for group in stat_groups:
                    method = group.find('div', class_='c-stat-3bar__label').text.strip()
                    value = group.find('div', class_='c-stat-3bar__value').text.strip()
                    donnees_combattant.append(f"{title} - {method}: {value}")

            return donnees_combattant

        donnees_combattant = process_stat_blocks(soup)

        # Extraire des informations sur les coups et les ajouter à donnees_combattant
        for target_group in soup.find_all('g', id=lambda x: x and x.endswith('-txt')):
            target = target_group.find_all('text')[-1].get_text(strip=True)
            value = target_group.find('text', id=lambda x: x and x.endswith('_value')).get_text(strip=True)
            percent = target_group.find('text', id=lambda x: x and x.endswith('_percent')).get_text(strip=True)
            donnees_combattant.append(f"{target} - Nombre de coups: {value}")
            donnees_combattant.append(f"{target} - Pourcentage: {percent}")

        # Extraire des informations sur les comparaisons de statistiques
        stat_compare_blocks = soup.find_all('div', class_='c-stat-compare')
        for block in stat_compare_blocks:
            stat_groups = block.find_all('div', class_='c-stat-compare__group')
            for group in stat_groups:
                stat_label = group.find('div', class_='c-stat-compare__label').get_text(strip=True)
                stat_number = group.find('div', class_='c-stat-compare__number').contents[0].strip() if group.find('div', class_='c-stat-compare__number') is not None else '0'
                stat_value = f"{stat_number}%" if group.find('div', class_='c-stat-compare__percent') else stat_number
                donnees_combattant.append(f"{stat_label}: {stat_value}")

        # Extraire des informations supplémentaires et les ajouter à donnees_combattant
        stat_containers = soup.find_all('div', class_='c-overlap__inner') + soup.find_all('div', class_='athlete-stats__stat')
        for container in stat_containers:
            stat_text = container.find('p', class_='athlete-stats__text athlete-stats__stat-text').get_text(strip=True) if container.find('p', class_='athlete-stats__text athlete-stats__stat-text') else container.find('h2', class_='e-t3').get_text(strip=True)
            stat_number = container.find('p', class_='athlete-stats__text athlete-stats__stat-numb').get_text(strip=True) if container.find('p', class_='athlete-stats__text athlete-stats__stat-numb') else '0'
            donnees_combattant.append(f"{stat_text}: {stat_number}" if stat_number else '0')

        donnees_combattants.append(donnees_combattant)
        print(i)

# Convertir la liste de données de combattants en DataFrame
DF = pd.DataFrame(donnees_combattants)

# Enregistrer les données dans un fichier CSV
chemin_csv = 'C:/Users/tmore/Desktop/VS Code/projet/infos.csv'
DF.to_csv(chemin_csv, encoding='utf-8', index=False)
print("Les données ont été enregistrées dans le fichier CSV :", chemin_csv)
