% segmenting data, taking fft, averaging over fft for each segment 

function varargout = segmenting_and_fft(varargin)
init

if nargin == 1
chx = varargin{1};
packet_power_chx = ones(f/2,1)*0;

for j = 1:floor(length(chx)/f)
    c1 = fft(chx(1 + (j-1)*f:(j)*f)) / (f/2);
    c1 = c1(1:f/2);
    c1 = (abs(c1)).^2;
    packet_power_chx = packet_power_chx + c1;
end

varargout{1} = packet_power_chx;


elseif nargin==2 | nargin==3
ch1 = varargin{1};
ch2 = varargin{2};

packet_power_ch1 = ones(f/2,1)*0;
packet_power_ch2 = ones(f/2,1)*0;
corr = ones(f/2,1)*0;
correlation = [];

for j = 1:floor(length(ch1)/f)

    c1 = fft(ch1(1 + (j-1)*f  : (j)*f )) / (f/2);
    c1 = c1(1:f/2);
    c2 = fft(ch2(1 + (j-1)*f  : (j)*f )) / (f/2);
    c2 = c2(1:f/2);

if nargin ==3 && varargin{3} == true
    corr = corr + c1.*conj(c2);
end
    c1 = (abs(c1)).^2;
    packet_power_ch1 = packet_power_ch1 + c1;   

    c2 = (abs(c2)).^2;
    packet_power_ch2 = packet_power_ch2 + c2;
end
packet_power_ch1 = packet_power_ch1 / floor(length(ch1)/f);
packet_power_ch2 = packet_power_ch2 / floor(length(ch2)/f);

varargout{1} = packet_power_ch1;
varargout{2} = packet_power_ch2;

if nargin==3 && varargin{3} == true
correlation = [correlation corr] / floor(length(ch1)/f);
varargout{3} = correlation;
end
end
end
