tic

f = 1024;  % FFT points
fs = 1.25*1e3; % Sampling frequency, MHz scale

% names of acquisitions
start = 0;
stop = 1888;


%data analysis for csv
power_array_ch1 = [];
power_array_ch2 = [];
ch1_fft_arr = [];
ch2_fft_arr = [];

% freq channel of interest
freq_start = 190;
freq_stop = 210;

a = floor(freq_start*f/fs);
b = floor(freq_stop*f/fs);


% satellite band
satellite_start = floor(250*f/fs);
satellite_end = ceil(270*f/fs);

% 
% % N points labelled on plot
% N = 10; 
% 
% % frequencies for plotting
% frequencies = (1:f/2)*fs/f;
% freqs_roi = (a:b)*fs/f;
% freq_array = linspace(freqs_roi(1),freqs_roi(end),N);
% 
% 
% % correlation initialization
% td_arr = [];
% corr_power_arr = [];
% cross_corr_2d = [];
% 
% 
% z = ones(f/2,1)*0;
% 

ch1_arr = [];
ch2_arr = [];

ch1_fft_arr = [];
ch1_f_fft_arr = [];
ch2_fft_arr = [];
ch2_f_fft_arr = [];

correlation_array = [];
correlation_array_f = [];

for var = start:stop
% file = uigetfile("MultiSelect","on","*.csv");

folder_name = 'jun_3_data';
% ts_file = readtable(append(folder_name,'/time_stamps.csv'),'NumHeaderLines',1);
% ts = timeofday(table2array(ts_file(:,3)));   
% clear ts_file

file_name = append(append(folder_name,'/tek'),num2str(var,'%04d'),'ALL.csv');
data_table = readtable(file_name,'NumHeaderLines',18);

ch1 = table2array(data_table(:,2));
ch1_f = filter(bpFilt,ch1);
ch2 = table2array(data_table(:,3));
ch2_f = filter(bpFilt,ch2);

% ch2 = ch1;

% ch1_arr = vertcat(ch1_arr, ch1);
% ch2_arr = vertcat(ch2_arr, ch2);

packet_power_ch1_f = ones(f/2,1)*0;
packet_power_ch2_f = ones(f/2,1)*0;

corr = zeros(f/2,1);
corr_f = corr;

for j = 1:floor((length(ch1))/f)

    c1 = fft(ch1(1 + (j-1)*f  : (j)*f )) / (f/2);
    c1 = c1(1:f/2);
    c2 = fft(ch2(1 + (j-1)*f:(j)*f)) / (f/2);
    c2 = c2(1:f/2);

    corr = corr + c1.*conj(c2);

    c1 = (abs(c1)).^2;
    packet_power_ch1 = packet_power_ch1 + c1;   

    c2 = (abs(c2)).^2;
    packet_power_ch2 = packet_power_ch2 + c2;

    c1 = fft(ch1_f(1 + (j-1)*f  : (j)*f )) / (f/2);
    c1 = c1(1:f/2);
    c2 = fft(ch2_f(1 + (j-1)*f:(j)*f)) / (f/2);
    c2 = c2(1:f/2);

    corr_f = corr_f + c1.*conj(c2);

    c1 = (abs(c1)).^2;
    packet_power_ch1_f = packet_power_ch1_f + c1;   

    c2 = (abs(c2)).^2;
    packet_power_ch2_f = packet_power_ch2_f + c2;

end

packet_power_ch1 = packet_power_ch1 / floor(length(ch1)/f);
ch1_fft_arr = [ch1_fft_arr packet_power_ch1];

packet_power_ch2 = packet_power_ch2 / floor(length(ch2)/f);
ch2_fft_arr = [ch2_fft_arr packet_power_ch2];

correlation_array = [correlation_array corr];

packet_power_ch1_f = packet_power_ch1_f / floor(length(ch1_f)/f);
ch1_f_fft_arr = [ch1_f_fft_arr packet_power_ch1_f];

packet_power_ch2_f = packet_power_ch2_f / floor(length(ch2_f)/f);
ch2_f_fft_arr = [ch2_f_fft_arr packet_power_ch2_f];
correlation_array_f = [correlation_array_f corr_f];

end

% correlation_spectrum = 10*log10(sum(abs(correlation_array).^2 , 2));

figure(2)
plot(mean(abs(correlation_array).^2))
plot(mean(abs(correlation_array_f).^2))

% figure(1000)
% correlation_power2 =mean(abs(dupe).^2);
% hold on
% plot(10*log10(correlation_power2) , 'cyan')
% plot(10*log10(mov_avg(correlation_power2 , 20)) , 'red')
% ylabel("Correlated Power")
% xlabel("Acquisitions")
% title("Correlated Power plot excluding RFI")
% hold off

toc