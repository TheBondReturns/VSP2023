unction power_plot(packet_power_ch1)

channel_no = inputname(1);
packet_power_ch1_band = packet_power_ch1(a:b);

try
packet_power_ch1_band(satellite_start-a+1 : satellite_end - a+1) = [];

catch ME

end
    

% ch1_fft_array = [ch1_fft_array packet_power_ch1]; % 2D FFT array

power_array_ch1 = [power_array_ch1 mean(packet_power_ch1)]; %total power in all channels of a given packet

hold on
figure(1)
plot(power_array_ch1,'green')
plot(mov_avg(power_array_ch1,100),color = 'red')
title(sprintf("%d",channel_name)
ylabel("Average power delivered")
xlabel("Acquisitions")
hold off