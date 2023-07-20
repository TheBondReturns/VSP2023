z = angle(cross_corr);

z_roi = z(a:b); %region of interest deduced from z's plot
x = 1:b-a+1;

% Plotting : 

hold on

figure(1)
plot(x,z_roi,'-o',color = 'red') 

p = polyfit(freqs_roi,z_roi,1);
slope = p(1); intercept = p(2);
fit = slope*freqs_roi + intercept;
plot(fit,color = 'blue')

legend('data in region of interest','fitted straight line')
ylabel("Phase difference between signals (in radians)")
xlabel("Frequencies (in MHz)")
xticks(linspace(0,b-a,N))
xticklabels(freq_array)
title(sprintf("Phase difference vs frequency for %d",var+1))

time_delay = p(1) / (2*pi)/1e6;
disp(sprintf("average time delay = %d", time_delay));

disp(sprintf("slope = %d", p(1)/1e6));
hold off


% Plotting time delay

% hold on
% figure(1)
% plot(td_arr,'cyan')
% plot(mov_avg(td_arr,100),color = 'red')
% title("Time delay calculated from slope")
% ylabel("Time delay")
% xlabel("Acquisitions")
% hold off
% toc





