clear all;
close all;
clc;
%%
N = 512;

[SigTime,Fs] = audioread("a1.wav");
l = length(SigTime);           
%y = dsp.FIRFilter('Numerator',[1 -0.97]);

[sigfft0,fl0,W0] = nieitfft(SigTime,Fs,2*N);

%x = levinson(SigTime,l);
%plot(x);

plot(fl0,abs(sigfft0(1:N))/N);grid on;
axis([0 2000 0 0.5]);
