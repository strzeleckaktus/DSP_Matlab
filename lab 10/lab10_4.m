clear; close all; clc;
% Input - parameters and signal x
L=4; M=50; N=2*M+1;  % L - down-sampling ratio
[x, fs] = audioread('violin.mp3');
[x1, fs1] = audioread('sample8000.wav');
Nx = length(x);

g = fir1(N-1, 1/L - 0.1*(1/L),kaiser(N,12)); % decimation filter design
[P,Q] = rat(8000/fs);
yd = resample(x, P, Q);

% samples to be removed are not calculated
ydpp = zeros(1,Nx/L)';

for k=1:L
ydpp = ydpp + filter( (g(k:L:end)), 1, x(L-k+1:L:end) );
end
fill = zeros(1, (length(ydpp)-length(x1)))';
x1 = [x1;fill];
soundsc(x, fs); pause;
soundsc(ydpp, 8000); pause;
soundsc(ydpp+x1, fs1);
figure
freqz(g, 1, L*Nx);
