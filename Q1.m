clear all;
clear all;
clc;

Win_ln = 25600;
audio = "a.wav";

frm = "a.frm";

[SigTime,Fs] = audioread(audio);
SigTime = SigTime(1:Win_ln,1);
Y = fft(SigTime);
P2 = abs(Y/Win_ln);
P1 = P2(1:Win_ln/2+1);
%P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(Win_ln/2))/Win_ln;
plot(f,mag2db( P1)) 
xlim([0 3000 ])
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')