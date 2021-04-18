clc; clear; close all;

Nx=1000; fs=2000; f0=fs/40; x=cos(2*pi*(f0/fs)*(0:Nx-1));
M=50; N=2*M+1; n=-M:M; h=(1-cos(pi*n))./(pi*n); h(M+1)=0;
f=-fs/2 : fs/2000 : fs/2;
w=kaiser(N,2)'; h = h.*w; %filtering the impulse response windowing to remove imperfections
xH = filter(h, 1, x);

x = x(M+1 : Nx-M);
xH = xH(2*M+1 : Nx);
xa = x + j*xH; Nx = length(xa);
figure(1)
plot (1:Nx,x,'r-',1:Nx,xH,'b-')
figure(2)
plot(x,xH,'bo-') 
f = fs/Nx *(0:Nx-1);
X = fft(x);
Xa = fft(xa);
figure(3)
plot(f, X, 'r'); hold on, grid on;
plot(f, Xa, 'b');