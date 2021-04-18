%Task6_1_0.m

clc; clear; close all;

fs = 1000; % sampling ratio (Hz)
N = 100; % number of signal samples, 100 or 1000, change to 1000 in task 1_2
dt=1/fs; t=dt*(0:N-1); % time scaling

% Signal
f0=50; %x = 100*sin(2*pi*f0*t); % signal with frequency f0 = 50,100,125,200 Hz
figure(1); 
%plot(t,x,'bo-'); xlabel('t[s]'); title('x(t)'); grid;

%w = ones(1,N) %task 1_4
w = chebwin(N,100)'; %task 1_6
%x=w  
%x = w.*(sin(2*pi*50*t)+sin(2*pi*125*t)) %task 1_5, task 1_7

%x = (sin(2*pi*50*t)+0.001*sin(2*pi*125*t)) %task 1_8
x = w.*(sin(2*pi*50*t)+0.001*sin(2*pi*125*t)) %task 1_9

% FFT spectrum
X = fft(x); % FFT
f = fs/N *(0:N-1); % frequency axis
k=1:N/2+1; %task 1_1
figure(2); 
%plot(f,1/N*abs(X),'bo-'); xlabel('k'); title('X(k)'); grid; %initial task
X = 20*log10(2/N*abs(X(k))) %task 1_3
plot(f(k),X(k), '-bo'); xlabel('k'); title('X(k)'); grid; %task
%1_1



