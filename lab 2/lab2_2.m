clear; clc; close all;

fs = 1000; A1 = 0.5; Nx = 10*fs; f1 = 1; p1=pi/4; 
df = 200; dt = 1/fs; t = dt*(0:Nx-1);
x1 = A1*sin(2*f1*pi*t+p1);
x2=cos(2*pi*(0*t+0.5*df*t.^2));
figure(1)
    plot(t, x2, 'o-'); grid;
sound(x2, fs);
pause(10)

fs=8000; Nx=10*fs; A1=0.5; f1=1; p1=pi/4; df=2000; dt = 1/fs; t = dt*(0:Nx-1);
x1 = A1*sin(2*pi*f1*t+p1);
x2=cos(2*pi*(0*t+0.5*df*t.^2));


figure(2);
    plot(t, x2, 'o-'); grid;
sound(x2, fs)

spectogram(x2, 256, 256-64, 512, fs)