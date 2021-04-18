 clear all; close all; clc;

fs1 = 8000;   %sampling frequency
fs2 = 48000;
bits1 = 8;
bits2 = 16;
channels = 1;

record1 = audiorecorder(fs1, bits1, channels);
record2 = audiorecorder(fs2, bits2, channels);

disp('Press any key to record audio'); pause;
record(record1);
record(record2);
pause(3);
stop(record1);
stop(record2);
play(record1);
pause(4);
play(record2);
pause(4);
%getting audio data

 audio1 = getaudiodata( record1, 'single' );
audio2 = getaudiodata( record2, 'single' );

x1 = audio1; clear audio1;
x2 = audio2; clear audio2;
Nx1 = length(x1); Nx2 = length(x2);
n1 = 0:Nx1-1; n2 = 0:Nx2-1;
dt1 = 1/fs1; dt2 = 1/fs2;
t1 = dt1*n1; t2 = dt2*n2;

figure(1)
    tiledlayout(3, 1);
    nexttile
    plot(t1, x1, 'b-'); grid; title('low quality');
    nexttile
    plot(t2, x2, 'g-'); grid; title('high quality');
    nexttile
    plot(t1, x1, 'b-'); grid; hold on; title('comparison');
    plot(t2, x2, 'g-'); hold off;

