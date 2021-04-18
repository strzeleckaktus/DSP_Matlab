%part 1 f2 = fs+f1, f3 = 2*fs+f1
clear all; close all;
fs = 500; Nx = 500; dt = 1/fs; t = dt*(0:Nx);
A = 1;
f1 = 1; f1_2 = fs+f1; f1_3 = 2*fs+f1;
p = pi/2;

x1_1 = A*sin(2*pi*f1*t + p);
x1_2 = A*sin(2*pi*f1_2*t + p);
x1_3 = A*sin(2*pi*f1_3*t + p);
figure(1)
plot(t, x1_1, 'bo-'); grid on; hold on; title('Signal x(t)'); xlabel('Line[s]'); ylabel('Amplitude'); pause(0.5);
plot(t, x1_2, 'go-'); pause(0.5);
plot(t, x1_3, 'yo-'); hold off;

%part 2 %f2 = fs-f1, f3 = 2*fs-f1

f1_2 = fs - f1; f1_3 = 2*fs-f1;

figure(2)
plot(t, x1_1, 'bo-'); grid on; hold on; title('Signal x(t)'); xlabel('Line[s]'); ylabel('Amplitude'); pause(0.5);
plot(t, x1_2, 'go-'); pause(0.5);
plot(t, x1_3, 'yo-'); hold off;

%part 3 f1 = 5;
f1 = 5;

figure(3)
plot(t, x1_1, 'bo-'); grid on; hold on; title('Signal x(t)'); xlabel('Line[s]'); ylabel('Amplitude'); pause(0.5);
plot(t, x1_2, 'go-'); pause(0.5);
plot(t, x1_3, 'yo-'); hold off;

%part 4 cosine instead of sine
 
x4_1 = A*cos(2*pi*f1*t + p);
x4_2 = A*cos(2*pi*f1_2*t + p);
x4_3 = A*cos(2*pi*f1_3*t + p);

figure(4)
plot(t, x1_1, 'bo-'); grid on; hold on; title('Signal x(t)'); xlabel('Line[s]'); ylabel('Amplitude'); pause(0.5);
plot(t, x1_2, 'go-'); pause(0.5);
plot(t, x1_3, 'yo-'); hold off;

%part 5 Fs = 8000, Nx = 3*Fs, f1 = 200;
fs = 8000; Nx = 3*fs; f1 = 200; f1_2 = fs+f1; f1_3 = 2*fs + f1; dt = 1/fs; t = dt*(0:Nx);
x1_1 = A*sin(2*pi*f1*t + p);
x1_2 = A*sin(2*pi*f1_2*t + p);
x1_3 = A*sin(2*pi*f1_3*t + p);

sound(x1_1, fs); pause(2);
sound(x1_2, fs); pause(2);
sound(x1_3, fs); pause(2);
