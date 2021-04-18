clc; close all; clear all;

[y1, fs1] = audioread('loong.wav');
y1 = y1(:,1);
y1_1 = y1(1:20000);
y1_2 = y1(20000:40000);
y1_3 = y1(40000:60000);
y1_4 = y1(60000:80000);
y1_5 = y1(80000:100000);

y = [y1_3;y1_5;y1_1;y1_2;y1_4];

sound(y, fs1);

