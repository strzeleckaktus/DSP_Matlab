clc; clear; close all;

Nx=1000; fs=2000; f0=fs/40; x=cos(2*pi*(f0/fs)*(0:Nx-1));

xa1 = hilbert(x); %hilbert filter using matlab function


X=fft(x);
n=1:Nx/2; X(n)=-1i*X(n); % positive frequencies
X(1)=0; X(Nx/2+1)=0;
n=Nx/2+2:Nx; X(n)= 1i*X(n); % negative frequencies
xH=real(ifft(X));
xa2=x+1i*xH; % analytic signal
figure(1)
plot(x, xH, '-ob');

figure(2)
plot(x, 'r'); hold on; grid on;
plot(xH, 'g');

f = fs/Nx *(0:Nx-1);
X = fft(x);
Xa = fft(xa1);
figure(3)
plot(f, X, 'r'); hold on, grid on;
plot(f, Xa, 'b');
