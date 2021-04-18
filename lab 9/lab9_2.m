
clc; clear; close all;



samples = [1,40000];
[m,fs] = audioread('bird.wav',samples); 
[p,fs] = audioread('wolfhowl01.WAV', samples);% for highpass
%[p,fs] = audioread('bass_sweep.mp3', samples); % for lowpass
p = p(:, 1);
m = m(:, 1);
x = m + p; % mixture of two sounds
fs = 22050
f = 0:1:0.5*fs;

Nx = length(x);                                         % get number of samples,
n= 0:Nx-1;                                        
dt = 1/fs;                                              % calculate sampling period
t = dt*n;                                               % calculate time stamps

%sound(x,fs);
figure(1);
spectrogram(x, 1024, 1024-32, f, fs)
figure(2);
spectrogram(m, 512, 512-32, f, fs)
figure(3);
spectrogram(p, 1024, 1024-32, f, fs)

M= fft(m);
P= fft(p);
X= fft(x);

figure(4);
plot(t, M);
figure(5);
plot(t, P);
figure(6);
plot(t, X);

G = 101;
b = fir1(G, 4000/(fs/2), 'high'); % for highpass
%b = fir1(G, 1500/(fs/2), 'low'); % for lowpass
%b = fir1(G, [1500/(fs/2), 3000/(fs/2), 4500/(fs/2), 6000/(fs/2)], 'DC-0');
%% experimenting with bandpass

C = length(b);
bx = zeros(1,C); % buffer for input samples x(n)
for n = 1 : Nx % MAIN LOOP
bx = [ x(n) bx(1:C-1) ]; % put new x(n) into bx buffer
y(n) = sum( bx .* b ); % do filtration, find y(n)
end %

Y = fft(y);
figure(7)
plot(t, Y);
sound(y,fs);
figure(8);
plot(y);
figure(9);
spectrogram(y, 512, 512-32, f, fs);
