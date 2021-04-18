  close all; clear all; clc;

[y1, fs1] = audioread('loud.wav');
[y2, fs2] = audioread('whisper.wav');

sound(y1, fs1);
pause(3);
sound(y2, fs2);

Nx1 = length(y1);
n1 = 0:Nx1-1;
dt1 = 1/fs1;
t1 = dt1*n1;

Nx2 = length(y2);
n2 = 0:Nx2-1;
dt2 = 1/fs2;
t2 = dt2*n2;

figure(1)
    tiledlayout(2,1)
    nexttile
    plot(t1, y1, '-'); grid; title('shout');
    nexttile
    plot(t2, y2, '-'); grid; title('whisper');