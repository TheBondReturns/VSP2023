#!/usr/bin/env python
# coding: utf-8

import socket
import numpy as np
import struct
import matplotlib.pyplot as plt

# Define the server's IP address and port
server_ip = '172.16.101.79'  # Set it to '0.0.0.0' to listen on all network interfaces
server_port = 51490

# Create a listener TCP socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the IP address and port
server_socket.bind((server_ip, server_port))

# Listen for incoming connections
server_socket.listen(1)
print('Server listening on {}:{}'.format(server_ip, server_port))


# Accept a client connection
client_socket, client_address = server_socket.accept()
print('Accepted connection from {}:{}'.format(client_address[0], client_address[1]))

# Create a buffer to store received data
buffer_size = 128 # Choose an appropriate buffer size
data_buffer = b''  # Use a bytes object to store binary data

# Receive and store data until the client closes the connection
data_all = [];
N = 10000
for i in range(N):
  bytes_data = client_socket.recv(buffer_size)
  if not bytes_data:
      break  # Client has closed the connection
  data = np.frombuffer(bytes_data, dtype=np.int16)  # convert 16-bit data to int16 
  print(len(data))
  data_all.append(data)
  
file_path="data.txt"
np.savetxt(file_path,np.hstack(data_all))
# # Process the received data
print('Received data')


# Close the sockets
client_socket.close()
server_socket.close()



