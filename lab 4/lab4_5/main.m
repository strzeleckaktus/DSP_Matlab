clear all; close all;

N = 100;
fs = 1000; dt=1/fs; t=dt*(0:N-1); df = 10; % 10 -> 1 at 5.2
fmax = 2.5*fs; % 2.5 -> 0.5 at 5.3
fx1 = 100;
fx2=250; Ax2=0.001;

% Signal

x1 = cos(2*pi*fx1*t);
x2 = Ax2*cos(2*pi*fx2*t);
x = x1;% + x2;
stem(x); title('x(n)'); pause

%windowing

w1 = boxcar(N)';
w2 = hanning(N)';
w3 = chebwin(N,140)';
w = w1;
stem(w); title('w(n)'); pause 
x = x .* w;
stem(x); title('xw(n)'); pause

% DFT - later in this chapter (red circles)
% k=0:N-1; n=0:N-1; F = exp(-j*2*pi*(k’*n)); X = (1/N)*F*x;
f0 = fs/N; f1 = f0*(0:N-1); % DFT freq step = f0 = 1/(N*dt) 
for k = 1:N
    X1(k) = sum( x .* exp(-j*2*pi/N* (k-1) *(0:N-1) ) )/ N;
    % X1(k) = sum( x .* exp(-j*2*pi/N* (f1(k)/fs) *(0:N-1) ) )/ N;
end
%X1 = N*X1/sum(w); % scaling for any window

%DtFT

f2 = -fmax : df : fmax; % df = 10 --> 1; first this freq. range 
for k = 1 : length(f2)
    X2(k) = sum( x .* exp(-j*2*pi* (f2(k)/fs) *( 0:N-1) ) ) / N; 
end
%X2 = N*X2/sum(w);

%plots


figure(1);
    tiledlayout(2,1)
    nexttile
    plot(f1,abs(X1),'ro',f2,abs(X2),'b-');
    xlabel('f (Hz)'); grid; %pause
    nexttile
    plot(f1,20*log10(abs(X1)),'ro',f2,20*log10(abs(X2)),'b-');
    xlabel('f (Hz)'); grid; %pause