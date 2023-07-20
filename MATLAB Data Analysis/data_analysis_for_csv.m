
init
tic
f = 1024;  % FFT points
fs = 1.25*1e3; % Sampling frequency, MHz scale

folder_name = "June14_Solar_Observation";

start = 0; % acquisitions start
stop = 2681; %acquisitions stop

% importing data and splitting into channels (for each packet):
for var = start:stop 

% ts_file = readtable(append(folder_name,'/time_stamps.csv'),'NumHeaderLines',1);
% ts = timeofday(table2array(ts_file(:,3)));   
% clear ts_file

file_name = append(append(folder_name,'/tek'),num2str(var,'%04d'),'ALL.csv');

data_table = readtable(file_name,'NumHeaderLines',18);

ch1 = table2array(data_table(:,2));
ch2 = table2array(data_table(:,3));
% segmenting data, taking fft, averaging over power of all segments 

[packet_power_ch2,packet_power_ch1,correlation] = segmenting_and_fft(ch2,ch1,true);

correlation_array = [correlation_array correlation];


ch1_fft_arr = [ch1_fft_arr packet_power_ch1];
ch2_fft_arr = [ch2_fft_arr packet_power_ch2];
end

correlated_power = mean(abs(correlation_array) , 1);
correlation_spectrum = mean(abs(correlation_array) , 2);

ch1_spectrum = mean((ch1_fft_arr) , 2);
ch1_power = mean((ch1_fft_arr) , 1);
ch2_spectrum = mean((ch2_fft_arr) , 2);
ch2_power = mean((ch2_fft_arr) , 1);

toc

% 
% % a = floor(190*f/fs);b = ceil(173*f/fs); 
% % (~190 to 210MHz)
% 
% %%% PHASE PLOT
% subplot(1,1,1);
% plot(phase*180/pi);
% title("Phase plot during solar transit; linear phase change in frequency range 190-210MHZ");
% 
% % Generate tick positions
% numTicks = 5; % Number of ticks
% tickPositions = round(linspace(1, length(phase), numTicks));
% xticks(tickPositions);
% 
% % Generate tick labels
% tickLabels = cell(1, numTicks);
% hourIncrement = floor(length(phase) / numTicks);
% for i = 1:numTicks
%     tickLabels{i} = num2str(i + 9); % Add 9 to start from 10
% end
% xticklabels(tickLabels);
% 
% ylabel('Phase (deg)');
% xlabel("Time (hours)");

