clc; clear; close all;

%my voice
[v,fs] = audioread('sample8000.wav', [1,8000]);
v = v(:,1);

f0 = 1000;
fF = 0.25;
kF = 500;
t = 0: 1/fs:1;

s=sin(2*pi*1000*t);
s= s(1:end-1);

x = [0 0 0 0 0.25*s(1:end-4)];

d = s.' + v;
%sound(d, fs);
%pause(5);

M = 100;
mi = 0.1;
gamma = 0.001;
lambda = 0.999;
delta = 1;
ialg = 1;

[y1, e1, h1] = adaptTZ(d,x,M,mi,gamma,lambda,delta,ialg); %pause;

s=sin(2*pi*(f0*t + kF*cos(2*pi*fF*t)));
s= s(1:end-1);
x = [0 0 0 0 0.25*s(1:end-4)];
d = s.' + v;

[y2, e2, h2] = adaptTZ(d,x,M,mi,gamma,lambda,delta,ialg); %pause;

[xx, fs2] = audioread('violin.mp3');

x2 = resample(xx,8000,fs2);
x2 = x2(1:8000).';

x = [0 0 0 0 0.25*x2(1:end-4)];
d = x2.' + v;

[y3, e3, h3] = adaptTZ(d,x,M,mi,gamma,lambda,delta,ialg); %pause;

figure(4);
    tiledlayout(2,1);
    nexttile;
    plot(y1);
    nexttile;
    plot(e1);
figure(5)
    tiledlayout(2,1);
    nexttile;
    plot(y2);
    nexttile;
    plot(e2);
figure(6)
    tiledlayout(2,1);
    nexttile;
    plot(y3);
    nexttile;
    plot(e3);

sound(e1,8000);