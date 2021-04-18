% dsp10_ex_down.m - Signal down-sampling
clear; close all; clc;
% Input - parameters and signal x
L=4; M=50; N=2*M+1; Nx=1000; % L - down-sampling ratio
x = sin(2*pi*(0:Nx-1)/50); plot(x) % signal to be down-sampled

% Slow down-sampling (decimation)
% one convolution of filter weights with signal samples, then dcimation
%g = fir1(N-1, 1/L - 0.1*(1/L),kaiser(N,12)); % decimation filter design
g = fir1(N-1, 1/L - 0.1*(1/L),hanning(N));
y = filter(g,1,x); % filtering

yd = y(1:L:end); % decimation
yd1=resample(x,1,L);
yd2=decimate(x,L);
n = M+1:Nx-M; nd = (N-1)/L+1:Nx/L;
figure; plot(n,x(n),'ro-',n(1:L:end),yd(nd),'bx'); title('x(n) and yd(n)');
err1 = max(abs(x(n(1:L:end))-yd(nd)))
% Fast polyphase down-sampling (decimation)
% L convolutions of PP components of original signal and filter weights
% samples to be removed are not calculated
x = [ zeros(1,L-1) x(1:end-(L-1)) ];
ydpp = zeros(1,Nx/L);
for k=1:L
ydpp = ydpp + filter( (g(k:L:end)), 1, x(L-k+1:L:end) );
end
err2 = [max(abs(yd-ydpp)), max(abs(yd-yd1)), max(abs(yd-yd2))]
figure
freqz(g, 1, L*Nx);