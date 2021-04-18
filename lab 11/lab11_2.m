clc; clear; close all;

Nx=1000; fs=2000; f0=fs/40; x=cos(2*pi*(f0/fs)*(0:Nx-1));
M=50; N=2*M+1; n=-M:M; h=(1-cos(pi*n))./(pi*n); h(M+1)=0;
figure(1)
stem(n,h); title('h(n)'); xlabel('n'); grid;

f=-fs/2 : fs/2000 : fs/2;
w=kaiser(N,10)'; h = h.*w; %filtering the impulse response windowing to remove imperfections
%w=chebwin(N,2)'; h=h.*w;
%w=hanning(1)'; h = h.*2;
H1 = polyval( h(end:-1:1), exp(-j*2*pi*f/fs) );
H2 = freqz(h,1,f,fs);
figure(2)
plot( f, 20*log10(abs(H1)) ); grid; xlabel('f [Hz]') ; %Passes all frequencies except 0
figure(3)
plot( f, unwrap(angle(H1)) ); grid; xlabel('f [Hz]') ; %incorrect due to shift in time
figure(4)
plot(f,angle(exp(j*2*pi*f/fs*M).*H1)); %figure 3 multiplied so we an get shifts depending on frequency
