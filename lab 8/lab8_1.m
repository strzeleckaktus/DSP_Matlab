%dsp08_ex_iir_intro.m
clear all; close all; clc;
% Design/choice of filter coefficients
fs = 2000; % sampling frequency
if(0) % choosing polynomial coefficients
b = [2,3]; % [ b0, b1 ]
a = [1, 0.2, 0.3, 0.4]; % [ a0=1, a2, a3, a4]
z = roots(b); p = roots(a); % [b,a] --> [z,p]
else % choosing polynomial roots
gain = 1e+7;
z = [ 1.5, 1.5 ] .* exp(j*2*pi*[ 300 ]/fs); z = [z conj(z)];
p = [ 0.99,0.99 ] .* exp(j*2*pi*[ 400 ]/fs); p = [p conj(p)];
b = gain*poly(z), a = poly(p), % [z,p] --> [b,a]
end
figure;
var = 0 : pi/1000 : 2*pi; c=cos(var); s=sin(var);
plot(real(z),imag(z),'bo', real(p),imag(p),'r*',c,s,'k-'); grid;
title('Zeros and Poles'); xlabel('Real()'); ylabel('Imag()');
% Verification of filter responses: amplitude, phase, impulse, step
f = 0 : 0.1 : 1000; % frequency in hertz
wn = 2*pi*f/fs; % normalized pulsation, radial frequency
zz = exp(-j*wn); % Z transform variable z^(-1)
H = polyval(b(end:-1:1),zz) ./ polyval( a(end:-1:1),zz); % ratio of two polynomials
% H = freqz(b,a,f,fs) % all-in-one Matlab function
figure; plot(f,20*log10(abs(H))); xlabel('f [Hz]'); title('|H(f)| [dB]'); grid;
figure; plot(f,unwrap(angle(H))); xlabel('f [Hz]'); title('angle(H(f)) [rad]'); grid;
zz = exp(j*wn); % Z transform variable
H = polyval(b,zz) ./ polyval(a,zz); % FR=TF for zz=exp(j*om): ratio of two polynomials
% H = freqz(b,a,f,fs) % all-in-one Matlab function
figure; plot(f,20*log10(abs(H))); xlabel('f [Hz]'); title('|H(f)| [dB]'); grid;
figure; plot(f,unwrap(angle(H))); xlabel('f [Hz]'); title('angle(H(f)) [rad]'); grid;