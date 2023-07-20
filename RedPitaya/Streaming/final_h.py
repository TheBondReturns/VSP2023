#!/usr/bin/env python
import os
import socket
import numpy as np
import matplotlib.pyplot as plt
import datetime

client  = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

ip=socket.gethostbyname("172.16.101.54") # IP of redpitaya in server mode: 
port=8900 

address=(ip,port)
client.connect(address)  


#time = datetime.timedelta(seconds=1);
#start_time = datetime.datetime.now();
#end_time = start_time + time;

data_all = [];

N = 5
for i in range(N):

     bytes_data = client.recv(4096)  # set the amount of data transferred
     data = np.frombuffer(bytes_data, dtype=np.int16)  # convert 16-bit data to int16 
     print(len(data))
     #data = np.array(data, dtype=int)
     data_all.append(data)  # Append the received data to the list.
   
     #if datetime.datetime.now() > end_time:
      #    break

file_path="data.txt"
np.savetxt(file_path,np.hstack(data_all))
print(np.array(np.hstack(data_all)).shape)
#for x in range(0, Nl):
#    print("test1")
#    bytes_data = client.recv(1024) # set the amount data transferred
#
 #   if bytes_data=None	
 #   if x == 0: 
 #       data = np.frombuffer(bytes_data, dtype=np.int16) # from 16bit data to int16 
 #       data = np.array(data, dtype=float)
 #       data_all = data
 #   else: 
 #       data = np.frombuffer(bytes_data, dtype=np.int16) # from 16bit data to int16 
 #       data = np.array(data, dtype=float)  
 #       data_all= np.hstack((data_all,data)) 

#%%



#FPS = 125e6        
#time = np.arange(0,np.size(data_all))/FPS

#plt.plot(time,data_all)


# In[101]:


#plt.plot(data_all[1:100])

