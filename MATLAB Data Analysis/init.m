global f fs start stop freq_start freq_stop a b satellite_start satellite_end frequencies freqs_roi freq_array z;

global ch1 ch2

%data analysis for csv

ch1_fft_arr = [];
ch2_fft_arr = [];
correlation_array = [];

% satellite band
satellite_start = floor(250*f/fs);
satellite_end = ceil(270*f/fs);



