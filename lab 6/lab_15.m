clc; close all; clear all;

[y1, fs1] = audioread('omg.wav');
[y2, fs2] = audioread('omg2.wav');
[y3, fs3] = audioread('omg3.wav');

f1 = 0:1:(fs1/2);
f2 = 0:1:(fs2/2);
f3 = 0:1:(fs3/2);
figure(1);
    tiledlayout(3,1)
    nexttile
    spectrogram(y1(:,1), 512, 512-64, f1, fs1);
    nexttile
    spectrogram(y2(:,1), 512, 512-64, f2, fs2);
    nexttile
    spectrogram(y3(:,1), 512, 512-64, f3, fs3);