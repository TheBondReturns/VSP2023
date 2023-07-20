load data.txt

n = 100000;
f = 125;

ft = abs(fft(data(1:n)));

ft = ft(1:end/2);

a = [];

for i = 1:length(ft)

if ft(i) == max(ft)

disp(strcat("maxima occurs at", num2str((i/n)*f), " MHz"))
disp(strcat("kB of samples = ",num2str(length(data)*16/8/1024)))

end
end


