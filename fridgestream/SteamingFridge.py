import numpy as np
import cv2
import base64
import time
import requests


cap  = cv2.VideoCapture(0)

# list of all the cameras connected to the computer
# for i in range(0, 10):
#     cap = cv2.VideoCapture(i)
#     if not cap.isOpened():
#         continue
#     else:
#         print(f"Camera {i} is available")


# once per minute
frame_rate = 1 / 60
prev = 0
b64_counter = 1

def send_frame(b64_frame):
    t = time.time()
    data = {'image': str(b64_frame).replace("b'", "").replace("'", "")}
    # send a PUT request to localhost:3000/freedge-status/1 with the image in json format
    response = requests.put('http://localhost:3000/freedge/1', json=data)
    response = requests.put('http://localhost:3000/freedge/2', json=data)
    response = requests.put('http://localhost:3000/freedge/3', json=data)


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
        # print(f"--- Base64 String {b64_counter} ---")
        send_frame(bck)
        # print(bck)
        b64_counter += 1
        cv2.imshow('frame', frame)




    if cv2.waitKey(1) == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()