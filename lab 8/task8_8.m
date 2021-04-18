
clc; clear; close all;



samples = [1,40000];
[m,fs] = audioread('bird.wav',samples); 
[p,fs] = audioread('wolfhowl01.WAV', samples);
p = p(:, 1);
m = m(:, 1);
x = m + p; % mixture of two sounds
fs = 22050
f = 0:1:0.5*fs;

Nx = length(x);                                         % get number of samples,
n= 0:Nx-1;                                        
dt = 1/fs;                                              % calculate sampling period
t = dt*n;                                               % calculate time stamps

%sound(x,fs);
figure(1);
spectrogram(x, 1024, 1024-32, f, fs)
figure(2);
spectrogram(m, 512, 512-32, f, fs)
figure(3);
spectrogram(p, 1024, 1024-32, f, fs)

M= fft(m);
P= fft(p);
X= fft(x);

figure(4);
plot(t, M);
figure(5);
plot(t, P);
figure(6);
plot(t, X);

% Design/choice of filter coefficients
if(0) % choosing polynomial coefficients
b = [2,3]; % [ b0, b1 ]
a = [1, 0.2, 0.3, 0.4]; % [ a0=1, a2, a3, a4]
z = roots(b); p = roots(a); % [b,a] --> [z,p]
else % choosing polynomial roots
gain = 0.4  ;
z = [ 1,1, 1, 1 ] .* exp(j*2*pi*[ 500, 700, 1050, 1200 ]/fs); z = [z conj(z)];
p = [ 0.99, 0.85, 0.85, 0.85, 0.99 ] .* exp(j*2*pi*[800,850, 900, 950, 1000 ]/fs); p = [p conj(p)];
b = gain*poly(z), a = poly(p), 

% [z,p] --> [b,a]
end
% Digital IIR filtration: x(n) --> [ b, a ] --> y(n)
% y=filter(b,a,x); % all-in-one Matlab function
M = length(b); % number of {b} coefficients
N = length(a); a = a(2:N); N=N-1; % number of {a} coeffs, remove a0=1
bx = zeros(1,M); % buffer for input samples x(n)
by = zeros(1,N); % buffer for output samples y(n)
for n = 1 : Nx % MAIN LOOP
bx = [ x(n) bx(1:M-1) ]; % put new x(n) into bx buffer
y(n) = sum( bx .* b ) - sum( by .* a ); % do filtration, find y(n)
by = [ y(n) by(1:N-1) ]; % put y(n) into by buffer
end

sound(y,fs);
figure(7);
plot(y);
figure(8);
spectrogram(y)
