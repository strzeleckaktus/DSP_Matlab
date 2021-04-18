clc; clear; close all;

N = 4; x = rand(1,N);

Xm = fft(x);
Xe = fft(x(1:2:N));
Xo = fft(x(2:2:N));

X = [Xe,Xe] + exp(-j*2*pi/N*(0:1:N-1)) .* [Xo,Xo];
error1 = max(abs(X-Xm)),

k = (0:N-1); 
n = (0:N-1);

A = exp(-j*(2*pi/N)*k'*n);

Ae = zeros(N,N/2); Ao = zeros(N,N/2); xe = zeros(N/2,1); xo = zeros(N/2,1);

Ao = A(:,(2:2:end));
xo = x(2:2:end);

Ae = A(:,(1:2:end-1));
xe = x(1:2:end-1);


X_new = Ae*xe.' + Ao*xo.';
error2 = max(abs(X_new.'-Xm)),