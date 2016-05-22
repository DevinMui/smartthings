import cv2
import base64
import requests
import time

cam = cv2.VideoCapture(0)
while True:
	r = requests.get("http://79dd4fa8.ngrok.io/api/v1/motions/")
	# wait for server to have motion value
	if(r.json()["motion"]):
		s, img = cam.read()
		cv2.imwrite("filename.jpg", img)
		# send data to places

		with open("filename.jpg", "rb") as image_file:
			'''

			# if no work
			files = {'file': open('filename.jpg', 'rb')}
			b = requests.post("https://182b90b9.ngrok.io", files=files)
			str = b.text
			'''
			encoded_string = base64.b64encode(image_file.read())
			headers = { "Content-Type": "application/json", "Accept": "application/json", "app_id": "de429518", "app_key": "f59ab30567145d21d5a878298409b270"}
			r = requests.post("https://api.kairos.com/recognize", {'image': encoded_string, 'gallery_name': 'gallery'})
			time.sleep(5)
			email = r.json().images.transaction.subject # gets subject's email then goes find
			p = requests.get("http://79dd4fa8.ngrok.io/api/v1/motions", {"email": email })
