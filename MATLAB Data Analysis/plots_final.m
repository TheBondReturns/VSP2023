% plots for 2 minute data
N = 5;
frequencies = (1:f/2)*fs/f;
freqs_roi = (150:350)*fs/f;
freq_array = linspace(freqs_roi(1),freqs_roi(end),N);

freq_start = 190;
freq_stop = 210;

a = floor(freq_start*f/fs);
b = floor(freq_stop*f/fs);

ch1_fft_band = ch1_fft_arr([floor(freq_start*f/fs):146 150:181 185:200 225:floor(freq_stop*f/fs)],:);
ch2_fft_band = ch2_fft_arr([1:146 150:181 185:200 225:end],:);


figure(1)

hold on
plot(10*log10(mean(ch1_fft_arr,2)),'red')
plot(10*log10(mean(ch2_fft_arr,2)),'blue')
% xticks(freq_array)
title("CH1 output with new setup")
legend("CH1","CH2")
hold off

figure(2)

plot(10*log10(sum(abs(correlation_array).^2 , 2)))
title("Correlation Spectrum")
 
figure(3)
plot(10*log10(mean(ch2_fft_arr,2)),'red')
title("CH2")

figure(4)
plot(10*log10(mean(ch1_fft_arr,2)),'blue')
title("CH1")


figure(1000)

num_acquisitions = size(ch1_fft_arr, 2); % Total number of acquisitions

start_time = datetime('11:00 AM', 'InputFormat', 'hh:mm a');
end_time = datetime('5:00 PM', 'InputFormat', 'hh:mm a');

% time_range = linspace(start_time, end_time, num_acquisitions); % Generate a time range
% 
% time_ticks = time_range(1:60:end); % Select every 60th time value for labeling (1 hour)
% time_labels = cellstr(datestr(time_ticks, 'hh:mm a')); % Convert time values to labels

imagesc(ch1_fft_arr)
% xticks(1:60:num_acquisitions)
% xticklabels(time_labels)






% num_acquisitions = size(ch1_fft_arr, 2); % Total number of acquisitions
% 
% start_time = datetime('11:00 AM', 'InputFormat', 'hh:mm a');
% end_time = datetime('5:00 PM', 'InputFormat', 'hh:mm a');
% 
% time_range = linspace(start_time, end_time, num_acquisitions); % Generate a time range
% 
% time_ticks = time_range(1:30:end); % Select every 30th time value for labeling
% time_labels = datestr(time_ticks, 'hh:mm a'); % Convert time values to labels
% 
% fs = 1.25e3;
% f = 1024;
% freq_min = 150; % Minimum frequency in MHz
% freq_max = 350; % Maximum frequency in MHz
% N = 10; % Number of points for labeling the y-axis
% freqs_roi = round(linspace(freq_min, freq_max, N), 1); % Generate rounded frequency range within ROI
% 
% imagesc(1:num_acquisitions, 1:f, ch1_fft_arr)
% yticks(round(linspace(1, f, N), 0))
% yticklabels(freqs_roi)
% ylabel("Frequency in MHz")
% title("CH1 waterfall plot 150 to 350 MHz")
% colorbar
% 
% num_acquisitions = size(ch1_fft_arr, 2); % Total number of acquisitions
% 
% start_time = datetime('11:00 AM', 'InputFormat', 'hh:mm a');
% end_time = datetime('5:00 PM', 'InputFormat', 'hh:mm a');
% 
% time_range = linspace(start_time, end_time, num_acquisitions); % Generate a time range
% 
% time_ticks = time_range(1:30:end); % Select every 30th time value for labeling
% time_labels = datestr(time_ticks, 'hh:mm a'); % Convert time values to labels
% 
% fs = 1.25e3;
% f = 1024;
% freq_min = 150; % Minimum frequency in MHz
% freq_max = 350; % Maximum frequency in MHz
% N = 10; % Number of points for labeling the y-axis
% freqs_roi = round(linspace(freq_min, freq_max, N), 1); % Generate rounded frequency range within ROI
% 
% imagesc(1:num_acquisitions, 1:f, ch1_fft_arr)
% yticks(round(linspace(1, f, N), 0))
% yticklabels(freqs_roi)
% ylabel("Frequency in MHz")
% title("CH1 waterfall plot 150 to 350 MHz")
% colorbar
% 
% xtick_interval = minutes(30); % Interval between labeled ticks (30 minutes)
% time_ticks_minutes = minutes(time_range - start_time);
% time_xticks = find(mod(time_ticks_minutes, xtick_interval) == 0);
% xticks(time_xticks)
% xticklabels(time_labels(time_xticks))
% xlabel("Time")