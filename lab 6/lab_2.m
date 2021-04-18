clear all; close all; 
fs = 1000; 
N = 100; % number of signal samples, 100 or 1000
dt=1/fs; t=dt*(0:N-1); 


% Signal


f0=50; x=sin(2*pi*50*t)+0.001*sin(2*pi*175*t); %first signal
%x = ones(1,N); %signal of ones


figure; plot(t,x,'bo-'); xlabel('t [s]'); title('x(t)'); grid;

% FFT spectrum

X = fft(x); % FFT
f = fs/N *(0:N-1); % frequency axis
figure; plot(f,1/N*abs(X),'bo-'); xlabel('k'); title('X(k)'); grid;

% FFT interpolation with signal windowing
K = 5; % interpolation order, later on changing between 1-10
w1 = rectwin(N);
w2 = chebwin(N,100);
w3 = hanning(N);
w = w1; % window choice
x = x.*w'; % signal windowing
X = fft(x,N); % without appended zeros
Xz = fft(x,K*N); % with zeros; Xz = fft([x,zeros(1,(K-1)*N)])/sum(w);
fz = fs/(K*N)*(0:K*N-1); % frequency axis
figure %
plot(f,20*log10(abs(X)/sum(w)),'bo-',fz,20*log10(abs(Xz)/sum(w)),'r.-','MarkerFaceColor','b');
xlabel('f (Hz)'); title('Zoomed DFT via FFT'); grid;