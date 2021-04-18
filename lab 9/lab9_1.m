%dsp09_ex_fir_intro.m

clear; close all; clc;

% Design/choice of filter coefficients b

fs = 2000; % sampling frequency
M = 101; % number of filter coefficients
%b = [ 1 2 3 ]; % filter/polynomial weights [b0, b1, b2, b3,...]
b = fir1(M, 100/(fs/2), 'high'); % window method: M coeffs, low-pass filter f0=100Hz
%b = fir2(M,[0 75 250 fs/2]/(fs/2),[1 1 0 0]); % inverse DFT: freq->gain
%b = firls(M,[0 75 250 fs/2]/(fs/2),[1 1 0 0],[1 10]); % optimal least-squares
%b = firpm(M,[0 75 250 fs/2]/(fs/2),[1 1 0 0],[1 10]); % min of max error

figure; stem(b); title('b(k)'); grid; 

% TF zeros plot
z = roots(b); % roots of nominator polynomial
    figure;
var = 0 : pi/1000 : 2*pi; c=cos(var); s=sin(var);
plot(real(z),imag(z),'bo', c,s,'k-'); grid;
title('TF Zeros'); xlabel('Real()'); ylabel('Imag()'); 

% Verification of filter responses: amplitude, phase, impulse, step
f = 0 : 0.1 : 1000; % frequency in hertz
wn = 2*pi*f/fs; % normalized pulsation, radial frequency
zz = exp(-j*wn); % Z transform variable z^(-1)
H = polyval(b(end:-1:1),zz); % FR=TF for zz=exp(-j*wn): polynomial value

% H = freqz(b,1,f,fs); % all-in-one Matlab function
figure; plot(f,20*log10(abs(H))); xlabel('f [Hz]'); title('|H(f)| [dB]'); grid;
figure; plot(f,unwrap(angle(H))); xlabel('f [Hz]'); title('angle(H(f)) [rad]'); grid;

% Input signal x(n) - two sinusoids: 20 and 500 Hz
Nx = 2000; % number of samples
dt = 1/fs; t = dt*(0:Nx-1); % sampling times
%x = zeros(1,Nx); x(1) = 1; % Kronecker delta impulse
x = sin(2*pi*20*t+pi/3) + sin(2*pi*500*t+pi/7); % sum of 2 sines
% Digital FIR filtration: x(n) --> [ b, ] --> y(n)
M = length(b); % number of {b} coefficients
bx = zeros(1,M); % buffer for input samples x(n)
for n = 1 : Nx % MAIN LOOP
bx = [ x(n) bx(1:M-1) ]; % put new x(n) into bx buffer
y(n) = sum( bx .* b ); % do filtration, find y(n)
end %
y1 = filter(b,1,x); % the same using filter()
y2 = conv(x,b); % the same using conv()
% FIGURES: comparison of input and output
figure;
subplot(211); plot(t,x); grid; % input signal x(n)
subplot(212); plot(t,y); grid;   % output signal y(n)
figure; % signal spectra of the second halves of samples (transients are removed)
k=Nx/2+1:Nx; f0 = fs/(Nx/2); f=f0*(0:Nx/2-1);
subplot(211); plot(f,20*log10(abs(2*fft(x(k)))/(Nx/2))); grid;
subplot(212); plot(f,20*log10(abs(2*fft(y(k)))/(Nx/2))); grid; 
figure;
    tiledlayout(2,1);
    nexttile;
    plot(t, x); grid;
    nexttile;
    plot(f,20*log10(abs(2*fft(y(k)))/(Nx/2)), 'b'); grid on; hold on;
    plot(f,20*log10(abs(2*fft(y1(k)))/(Nx/2)), 'r'); 
    plot(f,20*log10(abs(2*fft(y2(k)))/(Nx/2)), 'g'); hold off;