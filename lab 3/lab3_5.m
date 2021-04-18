clear all; close all; clc;

N=100; k=(0:N-1); n=(0:N-1); A=sqrt(2/N)*cos(pi/N*(k'+1/2)*(n+1/2));

x1 = ((2*3)*A(3,:))';
x2 = ((2*9)*A(9,:))';
x3 = ((2&7.5)*sqrt(2/N)*cos(pi/N*(7.5+1/2)*(n+1/2)))';
x4 = randn(N,1);
x = x4; %choose x1, x2, x3, x4, x1+x2, x1+x3, x1+x4
c = A'*x;
%c(3) = 0;
y = A'*c;
error = max(abs(x-y))


figure (1)
tiledlayout(3,1)
    nexttile
    plot (x, 'bo-'); grid;
    nexttile
    stem(c); grid;
    nexttile
    plot(y, 'bo-'); grid;

