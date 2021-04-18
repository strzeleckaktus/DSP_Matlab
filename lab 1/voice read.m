clear all; close all;

fs = 8000;
bits = 8;
channels = 1;
recording = audiorecorder(fs, bits, channels);
disp('press any key to rec audio'); pause;
record(recording);
pause(2);
stop(recording);
play(recording);
audio = getaudiodata(recording, 'single');


%verification

sound(audio, fs);
x = audio; clear audio;
Nx = length(x);
n = 0:Nx-1;
dt = 1/fs;
t = dt*n;

figure(1)
    tiledlayout(2,1)
    nexttile
    plot(x,'bo-'); xlabel('sample number n'); title('x(n)'); grid;
    nexttile
    plot(t,x,'b-'); xlabel('t (s)'); title('x(t)'); grid; 