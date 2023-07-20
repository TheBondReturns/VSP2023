#!/usr/bin/env python
import socket
import numpy as np
import matplotlib.pyplot as plt
import datetime
import asyncio


client  = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

ip=socket.gethostbyname("172.16.101.54") # IP of redpitaya in server mode: 

# run cat ddrdump.bit > /dev/xdevcfg
#compiled and run on redpitay  ./rp_remote_acquire -m 2 -k 0 -c 0 -d 0


port=51490 # default port for TCP 

address=(ip,port)
client.connect(address)  


time = datetime.timedelta(seconds=1);
start_time = datetime.datetime.now();
end_time = start_time + time;

data_all = [];

async def receive_data(client):
    data_all = []
    loop = asyncio.get_running_loop()
    while True:
        bytes_data = await loop.sock_recv(client, 4096*1024)  # Increase the buffer size
        if not bytes_data:
            break
        data = np.frombuffer(bytes_data, dtype=np.int16)
        data_all.append(data)
    return np.hstack(data_all)
    
async def main():
    # Assume you have already established the 'client' connection here
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    ip = socket.gethostbyname("172.16.101.54")  # IP of redpitaya in server mode

    # run cat ddrdump.bit > /dev/xdevcfg
    # compiled and run on redpitay  ./rp_remote_acquire -m 2 -k 0 -c 0 -d 0

    port = 51490  # default port for TCP

    address = (ip, port)
    client.connect(address)

    time = datetime.timedelta(seconds=1)
    start_time = datetime.datetime.now()
    end_time = start_time + time

    data_all = []
    data = await receive_data(client)
    np.savetxt("data.txt", data)

# Assuming you have set up the client connection here

# Run the asyncio event loop to execute the 'main' coroutine
asyncio.run(main())







#file_path="data.txt"
#np.savetxt(file_path,np.hstack(data_all))

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

