% dsp10_ex_up.m - Signal up-sampling
clear; close all; clc;
% Input - parameters and signal x
K=6; M=50; N=2*M+1;  % K - up-sampling ratio
[x, fs] = audioread('sample8000.wav');
Nx=length(x);
[x1, fs1] = audioread('violin.mp3');
h = K*fir1(N-1, 1/K, kaiser(N,12)); % interpolattion filter design
[P,Q] = rat(48e3/fs1);
yi = resample(x1,P,Q);

% Fast polyphase up-sampling (interpolation)
% K convolutions of original signal with K poly-phase filter weight sequences
% signal is not zeros-inserted
for k=1:K
yipp(k:K:K*Nx) = filter( h(k:K:end), 1, x);
end
yi = yi';
fill = zeros(1, (length(yi)-length(yipp)));
yipp = [yipp, fill];
soundsc(x, fs); pause;
soundsc(yipp, fs*6); pause;
soundsc(yipp+yi, fs*6); pause;
%soundsc(yi, fs*6);
figure
freqz(h, 1, K*Nx);


