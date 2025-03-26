
import json

with open('/home/tt262767/lab5dss/DS2002-json-practice/data/schacon.repos.json', 'r') as file:
    data = json.load(file)

# method 2
with open('chacon.csv', 'w') as file:
    for i, repo in enumerate(data[:5]):  # first 5 repos only
        file.write(f"{repo['name']},{repo['html_url']},{repo['updated_at']},{repo['visibility']}\n")
