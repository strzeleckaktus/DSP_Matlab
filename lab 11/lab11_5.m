%Task11_5.m

clc; clear; close all;
fs = 192000;
fc = 48000;


[x1,fsx] = audioread('sample8000.wav',[1,16000]);
[x2,fsx] = audioread('sample8000.wav',[1,16000]);

x1 = x1(:,1);
x2 = x2(:,1);
x1 = x1.';
x2 = x2.';

x1_up = interp(x1,fs/fsx);
x2_up = interp(x2,fs/fsx);

Nx = fs*2;
dt = 1/fs; % sampling period
t = dt*(0:Nx-1); % sampling times (many moments)

A=3; kA=2; xA = A*(1 + kA*x1_up).*sin(2*pi*fc*t);
kF=250; fF=1; xF = x2_up; 
x = xA .* sin(2*pi*(fc*t + cumsum(xF)*dt));
xa = hilbert( x );
xAest = abs( xa );
ang = unwrap(angle( xa ));
xFest = (1/(2*pi)) * (ang(3:end)-ang(1:end-2)) / (2*dt);
figure; plot(t,xA,'r-',t,xAest,'b-'); title('AM'); grid;
figure; plot(t,xF,'r-',t(2:Nx-1),xFest-fc,'b-'); title('FM'); grid;
xAFdown= resample(x,fsx,fs)
figure; plot(xAFdown)
soundsc(xAFdown,8000)
figure; plot(t,x1_up)