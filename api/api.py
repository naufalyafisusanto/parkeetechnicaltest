# 1. Buatlah Table dengan kolom
#    a. “Name”
#    b. “Web pages”
#    c. “Country”
#    d. “Domains”
#    e. “State Province”
#    Dari api berikut :
#    curl --location 'http://universities.hipolabs.com/search?country=United%2BStates'
#       - Buatlah scripting tersebut menggunakan python dengan library pandas.
#       - Buatlah parameter pencarian menggunakan python dengan kata kunci untuk memfilter “country”.
#       - Buatlah scripting untuk filtering data yang tidak memiliki data “state-province”.

import requests
import pandas as pd

countries = ['United States', 'Canada']
dfs = []

for country_name in countries:
    url = f'http://universities.hipolabs.com/search?country={country_name.replace(" ", "%20")}'
    response = requests.get(url)
    
    if response.status_code == 200:
        data = response.json()
        if data:
            df = pd.DataFrame(data)
            
            df = df[['name', 'web_pages', 'country', 'domains', 'state-province']]
            
            df_filtered = df.dropna(subset=['state-province'])
            
            df_filtered.columns = ['Name', 'Web pages', 'Country', 'Domains', 'State Province']
            
            dfs.append(df_filtered)
    else:
        print(f"Failed to retrieve data for {country_name}. HTTP Status Code: {response.status_code}")

if dfs:
    final_df = pd.concat(dfs, ignore_index=True)
    print(final_df)
else:
    print("No data retrieved for any country.")