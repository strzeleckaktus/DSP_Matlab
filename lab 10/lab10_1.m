% dsp10_ex_up.m - Signal up-sampling
clear; close all; clc;
% Input - parameters and signal x
K=5; M=50; N=2*M+1; Nx=1000; % K - up-sampling ratio
x = sin(2*pi*(0:Nx-1)/100); % signal to be up-sampled
% Slow up-sampling (interpolation)
% one convolution of filter weights with zero-inserted signal
xz = zeros(1,K*Nx); % # signal with inserted zeros
xz(1:K:end) = x; % #
%h = K*fir1(N-1, 1/K, hanning(N)); %different window
h = K*fir1(N-1, 1/K, kaiser(N,12)); % interpolattion filter design
yi = filter(h,1,xz); % signal filtering
%yi = interp(x,K);
%yi = resample(x,K,1);
n = M+1:K:K*Nx-M; ni = N:K*Nx-(K-1);
figure; plot(n,x(M/K+1:Nx-M/K),'ro-',ni-M,yi(ni),'bx'); title('x(n) and yi(n)');
err1 = max(abs(x(M/K+1:Nx-M/K)-yi(ni(1:K:end))))
figure;
stem(h);
% Fast polyphase up-sampling (interpolation)
% K convolutions of original signal with K poly-phase filter weight sequences
% signal is not zeros-inserted
for k=1:K
yipp(k:K:K*Nx) = filter( h(k:K:end), 1, x);
end
err2 = max(abs(yi-yipp))
figure(3)
freqz(h, 1, K*Nx);
