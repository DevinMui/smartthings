import cv2
import base64
import requests
import time

cam = cv2.VideoCapture(0)
while True:
	time.sleep(5)
	# wait for server to have motion value

	s, img = cam.read()
	cv2.imwrite("filename.jpg", img)
	# send data to places

	with open("filename.jpg", "rb") as image_file:
		encoded_string = base64.b64encode(image_file.read())
		requests.post({'image': encoded_string, 'gallery_name': 'gallery'})