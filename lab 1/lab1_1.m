
clear all; close all;
fs=100; Nx=100; A1=0.5; f1=1; p1=pi/4;
dt = 1/fs; p2 = 5*p1; t = dt*(0:Nx);
x1 = A1*sin(2*pi*f1*t+p1);
x2 = A1*sin(2*pi*f1*t+p2);

figure (1);

plot(t, x1, 'bo-'); grid on; hold on; title('Signal x(t)'); xlabel('Line[s]'); ylabel('Amplitude');
plot(t, x2, 'ko-'); hold off;

%part 2
fs2 = 500; Nx2 = 500; dt2 = 1/fs2; t2 = dt2*(0:Nx2);
A2_1 = 1; A2_2 = 2; A2_3 = 3;
f2_1 = 1; f2_2 = 2; f2_3 = 3;
p2_1 = pi/2; p2_2 = pi/4; p2_3 = pi/8;

x2_1 = A2_1*sin(2*pi*f2_1*t2 + p2_1);
x2_2 = A2_2*sin(2*pi*f2_2*t2 + p2_2);
x2_3 = A2_3*sin(2*pi*f2_3*t2 + p2_3);

x2 = x2_1+x2_2+x2_3;
figure(2)
    tiledlayout(2,3)
    nexttile
    plot(t2, x2_1, 'bo-');
    nexttile
    plot(t2, x2_2,'ko-');
    nexttile
    plot(t2, x2_3, 'yo-');
    nexttile([1 3])
    plot(t2, x2, 'bo-');
    
%part 3;

fs3 = 8000; Nx3 = 3*fs; dt3 = 1/fs3; t3 = dt3*(0:Nx3);
A3_1 = 1; A3_2 = 2; A3_3 = 3;
f3_1 = 100; f3_2 = 1000; f3_3 = 3000;

x3_1 = A3_1*sin(2*pi*f3_1*t3);
x3_2 = A3_2*sin(2*pi*f3_2*t3);
x3_3 = A3_3*sin(2*pi*f3_3*t3);
x3 = x3_1+x3_2+x3_3;

figure(3)
plot(t3, x3, 'bo-');
sound(x3, fs3);

