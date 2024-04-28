import numpy as np
import cv2
import base64
import time
import requests


server_url = 'testUrl'

cap  = cv2.VideoCapture(0)

frame_rate = 0.0001
prev = 0
b64_counter = 1

def send_frame(b64_frame):
    t = time.time()
    data = {'image': b64_frame, 'time': t}
    response = requests.post(server_url, json=data)


def frame_to_base64(frame):
    _, buffer = cv2.imencode('.jpg', frame)
    frame_b64 = base64.b64encode(buffer)
    return frame_b64

while True:

    time_elapsed = time.time() - prev
    res, image = cap.read()

    if time_elapsed > 1. / frame_rate:
        prev = time.time()

        # Do something with your image here.
        ret, frame = cap.read()
        bck = frame_to_base64(frame)
        print(f"--- Base64 String {b64_counter} ---")
        print(bck)
        b64_counter += 1
        cv2.imshow('frame', frame)




    if cv2.waitKey(1) == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()