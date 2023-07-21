#!/usr/bin/env python
import os
import socket
import numpy as np
import matplotlib.pyplot as plt
import datetime

client  = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

ip=socket.gethostbyname("172.16.101.59") # IP of redpitaya in server mode: 
port=51490 

address=(ip,port)
client.connect(address)  

#time = datetime.timedelta(seconds=500);
#start_time = datetime.datetime.now();
#end_time = start_time + time;

data_all = [];

while True:
    bytes_data = client.recv(1024)  # set the amount of data transferred
    data = np.frombuffer(bytes_data, dtype=np.int16)  # convert 16-bit data to int16 
    print(len(data))
    #data = np.array(data, dtype=int)
    data_all.append(data)  # Append the received data to the list.

    if len(data) == 0:
        client.close()
        break
          #  if datetime.datetime.now() > end_time:
   #     client.close()
   
file_path="data.txt"
print(np.array(np.hstack(data_all)).shape)
np.savetxt(file_path,np.hstack(data_all))

