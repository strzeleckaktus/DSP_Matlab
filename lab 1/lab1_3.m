clear all; close all;
fs = 8000; Nx = 3*fs; f1 = 100; dt = 1/fs; t = dt*(0:Nx-1);
s = randn(1,Nx);  % s2 = 0.1*s2;         % scaling to std=0.1

x1 = sin(2*pi*t*f1)
x2 = x1+s;

sound(x1, fs); pause(4);
sound(s, fs); pause(4);
sound(x2, fs); pause(4);

figure(1)
    tiledlayout(2,2)
    nexttile
    plot(t, x1, '.-'); grid; title('sine');
    nexttile
    histogram(x1, 20); grid; title('histogram of sine');
    nexttile
    plot(t, s, '.-'); grid; title('gaussian noise');
    nexttile
    histogram(s, 20); grid; title('histogram of gaussian noise');
    
    
figure(2)
    tiledlayout(1, 2)
    nexttile
    plot(t, x2, '.-'); grid; title('sine + noise');
    nexttile
    histogram(x2, 20); grid; title('histogram of sine + noise');

