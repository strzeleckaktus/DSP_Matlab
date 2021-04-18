clc; clear; close all;

fs = 8000; Nx = 5*fs; dt = 1/fs; t = dt*(0:Nx-1); A = 1; f0=1000; f = 1;
kA = 40; kF = 300; mA= sin(2*pi*f*t);

% signal moduleted - AM and FM
%x=A*(1+kA*mA).*sin(2*pi*(f0*t+kF*cumsum(mF)*dt));


x1=A*(1+kA*mA).*sin(2*pi*f0*t);
x2=A*sin(2*pi*(f0*t+kF*cumsum(mA)*dt));

x= (1+10*x1).*x1.*x2;

plot(t,x);

sound(x,fs);