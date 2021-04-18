function [y, e, h] = adaptTZ(d,x,M,mi,gamma,lambda,delta,ialg)
% M-filter length, LMS: mi, NLMS: mi, gamma, RLS: lambda, delta
% Initialization
h = zeros(M,1); % filter weights
bx = zeros(M,1); % input buffer for x(n) samples
Rinv = delta*eye(M,M); % inverse of auto-correlation matrix Rxx^{-1} of x(n)
for n = 1 : length(x) % adaptive filtering loop
    bx = [ x(n); bx(1:M-1) ]; % take new sample of x(n) into the buffer
    y(n) = h' * bx; % filter x(n): y(n) = sum( h .* bx)
    e(n) = d(n) - y(n); % calculate error e(n)
    if(ialg==1) % LMS
        h = h + mi * e(n) * bx; % update filter weights
    elseif(ialg==2) % NLMS
        energy = bx' * bx; % energy of signal x(n) in the buffer
        h = h + mi/(gamma+energy) * e(n) * bx; % update filter weights
    else % RLS
        Rinv = (Rinv - Rinv*bx*bx'*Rinv/(lambda+bx'*Rinv*bx))/lambda; % update
        h = h + Rinv * bx * e(n); % update
    end
end

fs = 8000;
f = 0:fs/2000:fs/2;

figure(1);
plot(abs(freqz(h,1,f,fs)));
title('Filter');

end