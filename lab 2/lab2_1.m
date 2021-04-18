clc; clear; close all;
fs = 100; Nx = 400; dt = 1/fs; t = dt*(0:Nx);

x2=sin(2*pi*1*t);
x3=exp(-5*t); 
x4=exp(-5*(t-0.5).^2);
x5=sin(2*pi*(0*t+0.5*20*t.^2));
x6=sin(2*pi*(10*t-(10/(2*pi*1)*cos(2*pi*1*t))));
x7=sin(2*pi*(10*t+10*cumsum(x2)*dt)); 

figure(1)
    tiledlayout(6, 1);
    nexttile
    plot(t, x2, 'b-'); grid; title('sine 1hz');
    nexttile
    plot(t, x3, 'g-'); grid; title('exponent decaying in time');
    nexttile
    plot(t, x4, 'b-'); grid; title('gaussian hat');
    nexttile
    plot(t, x5, 'y-'); grid; title('linear frequency increase');
    nexttile
    plot(t, x6, 'r-'); grid; title('sinusoidal FM');
    nexttile
    plot(t, x7, 'g-'); grid; title('sinusoidal FM');
    
    
    
% part 2

y1 = 0.5*x5+3*x3;
y2 = 1.5*x6+0.5*x4;
y3 = 0.25*x7+1.5*x5;
figure(2)
    tiledlayout(3, 1);
    nexttile
    plot(t, y1, 'g-'); grid; title('0.5*x5+3*x3');
    nexttile
    plot(t, y2, 'b-'); grid; title('1.5*x6+0.5*x4');
    nexttile
    plot(t, y3, 'y-'); grid; title('0.25*x7+1.5*x5');
    
z1 = (1+0.5*x2).*x7;
z2 = x3.*x5;
z3 = (1+0.5*x2).*x5;
z4 = (1+0.5*x4).*x6;

figure(3)
    tiledlayout(4, 1);
    nexttile
    plot(t, z1, 'g-'); grid; title('(1+0.5*x2).*x1');
    nexttile
    plot(t, z2, 'b-'); grid; title('x2.*x1');
    nexttile
    plot(t, z3, 'y-'); grid; title('(1+0.5*x2).*x5');
    nexttile
    plot(t, z4, 'g-'); grid; title('(1+0.5*x2).*x6');

