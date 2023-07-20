tic 

data = readtable("LPDA_Run4_6.5hrs_TestRFI22-05-2023.txt");
timestamps = table2array(data(:,width(data)));
data = table2array(data(:,1:width(data)-1));
data = data - 127.5;

packet_power = ones(1,512)*0;
avg_power = [];
fft_array = [];
n = height(data);
for j = 1:n

for i = 1:floor(width(data)/1024)

    c = fft(data(j,1 + (i-1)*1024:(i)*1024));

    c = (abs(c)).^2;

    packet_power = packet_power + c(1:512);

end

packet_power = packet_power / floor(length(data)/1024);
fft_array = vertcat(fft_array,packet_power);

avg_power = [avg_power sum(packet_power)];


end


imagesc(fft_array)
figure()

plot(mov_avg(avg_power,200))
figure()
plot(avg_power)




toc