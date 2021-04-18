% dsp12_ex_adapt.m
clear; close all;

% Task (AIC, ANC) and algorithm selection (LMS, NLMS, RLS)
isig = 1;   % 1=synthetic or 2=real signal
itask = 1;  % 1=adaptive interference canceling (e.g. cross-talk)
            % 2=adaptive signal de-noising using linear prediction method
ialg = 3;   % adaptation algorithm: 1=LMS, 2=NLMS (normalized LMS), 3=RLS

% LMS filter (Least Mean Squares)
M = 50;                 % number of adaptive filter coefficients (weights)
mi = 0.1;               % adaptation speed coefficient ( 0<mi<1)
% NLMS filter (normalized LMS), faster convergence
gamma = 0.001;          % not divide by zero constant e.g. = 0.001
% RLS filter (recursive LS) - more-complex, faster convergence
lambd = 0.999;          % RLS - forgetting factor for Least-Squares cost function
Rinv = 0.5*eye(M,M);    % RLS - inverse of Rxx matrix

%TEST SIGNALS
if(isig == 1) % SYNTHETIC SIGNALS =========================================
% Generation of an LFM (linear frequency modulation) 
env = 3;                    % choose information signal envelope:
                            % 0=rectangular, 1=alfa*t, 2=exp(-alfa*t), 3=Gauss,
fs = 1000;                  % sampling frequency
Nx = 1*fs;                  % number of samples
A = 1;                      % signal amplitude
f0 = 0;                     % LFM: initial signal frequency
df = 100;                   % LFM: frequency increase [Hz/s], SFM: modulation index [Hz]
fc = 1;                     % SFM: carrier frequency
fm = 1;                     % SFM: modulating frequency
f=0:fs/500:fs/2;            % frequencies for plots
dt=1/fs; t=0:dt:(Nx-1)*dt;  % time points for plots
s = A*cos( 2*pi* (f0*t + 0.5*df*t.^2) );                    % LFM SIGNAL
%s = A*cos( 2*pi* (fc*t + df/(2*pi*fm)*cos(2*pi*fm*t) );    % SFM SIGNAL

% ENVELOPE choice:
if (env==0) w = boxcar(Nx)'; end                        % 0 = rectangular
if (env==1) alfa=5; w=alfa*t; end                       % 1 = alfa*t
if (env==2) alfa=5; w=exp(-alfa*t); end                 % 2 = exp(-alfa*t)
if (env==3) alfa=10; w=exp(-alfa*pi*(t-0.5).^2); end    % 3 = Gauss

s = s .* w;                     % SIGNAL WITH ENVELOPE
if (itask==1)                   % TEST 1 - interference canceling
P = 0;                          % no prediction
x = 0.1*sin(2*pi*200*t-pi/5);   % interference delayed and attenuated
d = s + 0.5*sin(2*pi*200*t);    % signal + interference
end
if (itask==2)                   % TEST 2 - de-noising by prediction
P = 1;                          % prediction order set to 1,2,3,...)
x = s + 0.25*randn(1,Nx);       % signal + noise
d = [ x(1+P:length(x)) 0 ];     % signal x speed-up by P samples (earlier)
end
else % REAL SIGNALS =======================================================
[s, fs] = audioread('speech8000.wav'); s=s';
[sA,fs] = audioread('speakerA.wav'); sA=sA';
[sB,fs] = audioread('speakerB.wav'); sB=sB';
P = 1; % delay in samples
if(itask==1)                                % TEST 1
s = sA;                                     % reference for comparison
x = sB; Nx = length(x);                     % original echo signal
d = sA + 0.25*[ zeros(1,P) sB(1:end-P) ];   % added echo copy:
end                                         % weaker (0.25), delayed (P)
if(itask==2)
x = s; Nx = length(x);                      % original noisy speech
d = [ x(1+P:length(x)) zeros(1,P) ];        % signal x speed-up by P samples
end
f=0:fs/500:fs/2;                            % frequencies for plots
dt = 1/fs; t = dt*(0:Nx-1);                 % time for plots
end %======================================================================

% Figures - input signals
figure;
subplot(211); plot(t,x); grid; title('IN : signal x(n)');
subplot(212); plot(t,d); grid; title('IN : signal d(n)'); xlabel('time (s)'); 

% Calculation of optimal Wiener filter and limits for mi
for k = 0 : M
rxx(k+1) = sum( x(1+k:Nx) .* x(1:Nx-k) )/(Nx-M); % auto-correlation of x(n)
rdx(k+1) = sum( d(1+k:Nx) .* x(1:Nx-k) )/(Nx-M); % cross-correlation of d(n) and x(n)
end
Rxx = toeplitz(rxx,rxx);            % symmetrical autocorrelation matrix of x(n)
h_opt = Rxx\rdx';                   % weights of the optimal Wiener filter
lambda = eig( Rxx );                % eigenvalue decomposition of Rxx
lambda = sort(lambda,'descend');    % sorting eigenvalues
disp('Suggested values of mi')
mi1_risc = 1/lambda(1),
mi2_risc = 1/sum(lambda), 
figure;
subplot(211); stem( h_opt ); grid; title('Optimal Wiener filter h(n)');
subplot(212); stem( lambda ); grid; title('Eigenvalues of matrix Rxx');
% mi = mi2_risc/20;

% Adaptive filtration
bx = zeros(M,1);                    % initialization of buffer for input signal x(n)
h = zeros(M,1);                     % initialization of filter weights (coefficients)
y = [];
e = [];
for i = 1 : length(x)               % Main loop
bx = [ x(i); bx(1:M-1) ];           % put new sample of x(n) into the buffer
dest = h' * bx;                     % filtration of x(n) = prediction of d(n)
err = d(i) - dest;                  % prediction error
if (ialg==1)                        % LMS ########
h = h + ( 2*mi * err * bx );        % LMS - weights adaptation
end
if (ialg==2)                        % NLMS ########
eng = bx' * bx;                     % signal energy in bx
h = h + ( (2*mi)/(gamma+eng) * err * bx ); % weights adaptation
end
if (ialg==3)                        % RLS #########
Rinv = (Rinv - Rinv*bx*bx'*Rinv/(lambd+bx'*Rinv*bx))/lambd; % new Rinv
h = h + (err * Rinv * bx );         % new eights
end
if(0) % Observation of filter weights and filter frequency response
subplot(211); stem(h); xlabel('n'); title('h(n)'); grid;
subplot(212); plot(f,abs(freqz(h,1,f,fs))); xlabel('f (Hz)');
title('|H(f)|'); grid; % 
end
y = [y dest];
e = [e err];
end

% Figures - output signals
figure;
subplot(211); plot(t,y); grid; title('OUT : signal y(n) = dest');
subplot(212); plot(t,e); grid; title('OUT : signal e(n) = err');
xlabel('time [s]'); 
if (itask==1)
figure; subplot(111); plot(t,s,'r',t,e,'b'); grid; xlabel('time [s]');
title('Original (RED), filtration result (BLUE)'); 
end
if (itask==2)
n=Nx/2+1:Nx;
SNR_in_dB = 10*log10( sum( s(n).^2 ) / sum( (d(n)-s(n)).^2 ) ),
SNR_out_dB = 10*log10( sum( s(n).^2 ) / sum( (s(n)-y(n)).^2 ) ),
n=1:Nx-P;
figure; subplot(111); plot(t(n),s(n),'k',t(n),d(n),'r',t(n),y(n),'b');
grid; xlabel('time (s)');
title('Reference (BLACK), Noisy (RED), Filtered (BLUE)'); 
end
figure; subplot(111); plot(1:M+1,h_opt,'ro-',1:M,h,'bx-'); grid;
title('h(n): Wiener (RED), our (BLUE)'); xlabel('n'); 
