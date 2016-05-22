import requests

headers = { "Content-Type": "application/json", "app_id": "de429518", "app_key": "f59ab30567145d21d5a878298409b270"}
r = requests.post("https://api.kairos.com/enroll", data={'image': "https://182b90b9.ngrok.io/uploads/jesse.jpg", "subject_id": "jesseliang@ymail.com", 'gallery_name': 'gallery'}, headers=headers)
print r.text
r = requests.post("https://api.kairos.com/enroll", data={'image': "https://182b90b9.ngrok.io/uploads/devin.jpg", "subject_id": "devinmui@yahoo.com", 'gallery_name': 'gallery'}, headers=headers)
print r.text