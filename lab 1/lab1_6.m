clc; clear all; close all;

[y, fs] = audioread('ahoj.wav');
sound(y, fs);
t1 = length(y)*(1/fs);

dt= (0:1:length(y)-1);
dt = dt.';
pause(3);

sound(y, 8000);
pause(3);

sound(y, 32000);
pause(3);