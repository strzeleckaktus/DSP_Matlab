clear all; close all;

% Design/choice of filter coefficients
if(0) % choosing polynomial coefficients
b = [3,2]; % [ b1, b0 ]
a = [4,3,2,1]; % [ a3, a2, a1, a0=1]
z = roots(b); p = roots(a); % [b,a] --> [z,p]
else % choosing polynomial roots
gain = 1e+7;
z = j*2*pi*[ 300 ]; z = [z conj(z)];
p = [-1,-1] + j*2*pi*[400]; p = [p conj(p)];
b = gain*poly(z); a = poly(p); % [z,p] --> [b,a]
end
figure (1);
    tiledlayout(3,1)
    nexttile;
    plot(real(z),imag(z)/(2*pi),'bo', real(p),imag(p)/(2*pi),'r*'); grid;
    title('Zeros and Poles'); xlabel('Real()'); ylabel('Imag()'); 
% Verification of filter responses: amplitude, phase, impulse, step
f = 0 : 0.1 : 1000; % frequency in hertz
w = 2*pi*f; % pulsation, radial frequency
s = j*w; % Laplace transform variable
H = polyval(b,s) ./ polyval(a,s); % FR=TF for s=j*w: ratio of two polynomials
    nexttile;
    plot(f,20*log10(abs(H))); xlabel('f [Hz]'); title('|H(f)| [dB]'); grid; 
    nexttile;
    plot(f,unwrap(angle(H))); xlabel('f [Hz]'); title('angle(H(f)) [rad]'); grid; 
figure(2);
    impulse(b,a); % filter response to impulse on input
figure(3);
    step(b,a); % filter response to step change on input