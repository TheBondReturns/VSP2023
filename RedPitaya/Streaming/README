An SOP for accessing RedPitaya’s streaming feature:


1. Connect the laptop to the RedPitaya (or both to a common LAN network) and enter rp-f0964b.local/ (or whatever MAC address is written on the RedPitaya box) in the browser.

2. Note the redpitaya’s IP address from the Network Manager option under System in web interface.

3. Using an external input source (do NOT generate signal directly from the RedPitaya) connect it to one of the RedPitaya’s input ports and verify that it’s   
   working via the oscilloscope feature on the web interface.

4. SSH into RedPitaya; username and password both root.

5. In the root folder, I have created a folder called “streaming” which contains two files, ddrdump.bit and rp_remote_acquire. 

6. The ddrdump.bit file is the fpga image to be loaded to enable DMA by creating buffers in DDR (cat ddrdump.bit > /dev/xdevcfg to do so) then execute  
  ./rp_remote_acquire to view various options available.

--> For streaming data, 

The rp_remote_acquire executable works in two streaming modes, one as a client (-m 1) and one as a server (-m 2).

In the client mode, it waits for a connection from a server (TCP server that’s initiated via a python program that’s linked below); once the python program is run, execute the following command on the redpitaya terminal:

./rp_remote_acquire -m 1 -a {SERVER_IP} -p {SERVER_PORT} -k {KILOBYTES TO TRANSFER} -d 1  

The python program for acquiring in client mode is linked here.

In server mode, the redpitaya constantly pumps data into a socket, and we have to access data from the socket using a python program. Initially run the below command on Redpitaya terminal, then run the python program to extract data out of a socket:
	
./rp_remote_acquire -m 2 -a {SERVER_IP} -p {SERVER_PORT} -k {KILOBYTES TO TRANSFER} -d 1  

The python program for acquiring in client mode is linked here.

→ -d sets the decimation value, -a the IP address of the server and -p the port number for TCP, same as that given at the server.


The source codes by the author are present in this GitHub repository and the executable files & ecosystem are present in this dropbox. 

Further details about the functioning of the program are mentioned in this particular Redpitaya forum page



