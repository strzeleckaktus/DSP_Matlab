%dsp07_ex_analog_butter.m
clc; clear; close all;
N = 10; % number of TF poles
f0 = 100; % cut-off frequency of low-pass filter
alpha = pi/N; % angle of one ‘‘piece of cake’’
beta = pi/2 + alpha/2 + alpha*(0:N-1); % angles of poles
R = 2*pi*f0; % circle radius
p = R*exp(j*beta); % poles placed on circle, left half-plane
z = []; gain = prod(-p); % LOW-PASS: TF zeros are not used, gain
%z = zeros(1,N); gain = 1; % HIGH-PASS: N TF zeros in zero, gain
b = gain*poly(z); a=poly(p); % [z,p] --> [b,a]
b = real(b); a=real(a); %
% ... continue dsp07_ex_analog_intro.m




plot(real(z),imag(z),'bo', real(p),imag(p),'r*'); 
% Verification of filter responses: amplitude, phase, impulse, step
f = 0 : 0.1 : 1000; % frequency in hertz
w = 2*pi*f; % pulsation, radial frequency
s = j*w; % Laplace transform variable
%%x=0:pi/1000:2*pi; c=cos(x); s=sin(x); figure(6);plot(c,s,'k-');
H = polyval(b,s) ./ polyval(a,s); % FR=TF for s=j*w: ratio of two polynomials
%figure(1); plot(f,20*log10(abs(H))); xlabel('f [Hz]'); title('|H(f)| [dB]'); grid; 
%figure(2); plot(f,unwrap(angle(H))); xlabel('f [Hz]'); title('angle(H(f)) [rad]'); grid;
%figure(3); impulse(b,a);  % filter response to impulse on input
%figure(4); step(b,a);  % filter response to step change on input

x=0:pi/1000:2*pi; c=cos(x); s=sin(x);
figure(5);
title('Zeros and Poles'); xlabel('Real()'); ylabel('Imag()'); 
plot(real(z),imag(z),'bo', real(p),imag(p),'r*'); 
hold on; grid;
plot(c,s,'k-'); 
hold off;

figure(6);
semilogx(f,20*log10(abs(H)))