
clc; clear; close all;

[y,fs] = audioread('bird.wav');

c = dct(y);

figure(1)
stem(c,'o-');

N=25000; % orthogonal transformation (analysis) matrix
k=(0:N-1); n=(0:N-1); A=sqrt(2/N)*cos(pi/N*(k'+1/2)*(n+1/2));

p = 20000

if p <= 4855
    X = [zeros(1,4855-p),c(4855 - p:1: 4855)',c(4856),c(4857:+4857+p)',zeros(1,N-4856-p-2)];
else
    X = [c(1:1: 4856)',c(4857:+4857+p)',zeros(1,N-4856-p-1)];
end
%X = c(4856);

x_synth = A'*X';

sound(x_synth,fs)