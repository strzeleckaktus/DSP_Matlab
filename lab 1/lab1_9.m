clc; close all; clear all;

[y1, fs1] = audioread('voiced_phenomes.wav');
[y2, fs2] = audioread('unvoiced_phenomes.wav');
[y3, fs3] = audioread('voiced_plosives.wav');
[y4, fs4] = audioread('unvoiced_plosives.wav');

dt1 = (0:1:length(y1)-1);
dt2 = (0:1:length(y2)-1);
dt3 = (0:1:length(y3)-1);
dt4 = (0:1:length(y4)-1);

figure(1)
    tiledlayout(2, 2);
    nexttile
    plot(dt1, y1, 'b-'); grid; title('voiced phenomes');
    nexttile
    plot(dt2, y2, 'g-'); grid; title('unvoiced phenomes');
    nexttile
    plot(dt3, y3, 'y-'); grid; title('voiced plosives');
    nexttile
    plot(dt4, y4, 'p-'); grid; title('unvoiced plosives');