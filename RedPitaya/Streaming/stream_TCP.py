#!/usr/bin/env python
import socket
import numpy as np
import matplotlib.pyplot as plt
import datetime

client  = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

ip=socket.gethostbyname("172.16.101.59") # IP of redpitaya in server mode: 

port=51490 # default port for TCP 

address=(ip,port)
client.connect(address)  

time = datetime.timedelta(seconds=20);
start_time = datetime.datetime.now();
end_time = start_time + time;

data_all = [];

file_path = "data.bin"

while datetime.datetime.now()<end_time:
    bytes_data = client.recv(16384)
    
    # If there are no more bytes to receive, break the loop
   # if len(bytes_data) == 0:
    #    break

    # Append the received bytes to the file
    with open(file_path, "ab") as file:
        file.write(bytes_data)

client.close()


