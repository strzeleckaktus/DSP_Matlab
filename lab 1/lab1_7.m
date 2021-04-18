clc; clear all; close all; 

[y1, fs1] = audioread('lab1_7_2.wav');
[y2, fs2] = audioread('lab1_7_1.wav');

t1 = length(y1)*(1/fs1);
t2 = length(y2)*(1/fs2);

y1 = y1.';
y2 = y2.';
y3 = y2(:, 1:length(y1));
y3 = y3;

y = y1+y3;
dt1 = (0:1:length(y1)-1);
dt2 = (0:1:length(y2)-1);

sound(y1, fs1); pause(3);
sound(y2, fs2); pause(3);
sound(y, fs2);

figure(1)
    tiledlayout(3, 1);
    nexttile
    plot(dt1, y1, 'b-'); grid; title('first signal');
    nexttile
    plot(dt2, y2, 'g-'); grid; title('second signal');
    nexttile
    plot(dt1, y, 'b-'); grid; hold on; title('mixxd');