clear all;
clear all;
clc;
%%
Win_ln = 25600;
audio = "a.wav";

frm = "a.frm";

[SigTime,Fs] = audioread(audio);
[formants] = get_formants(SigTime,Fs,60);
SigTime = SigTime(1:end,1);
skip_val = 8;
index = (1:skip_val:length(SigTime));
Fs = Fs / skip_val;
SigTime = SigTime(index);
Win_ln = length(SigTime);
[a,e] = lpc(SigTime,12);


est_x = filter([0 -a(2:end)],1,SigTime);
%plot(SigTime);
%hold on;
%plot(est_x);
figure()
wl = Win_ln/8;
y = fft(SigTime(1:Win_ln/2));
p2 = abs(y*2/Win_ln);
p1 = p2(1:Win_ln/4+1);
f1 = Fs*(0:(Win_ln/4))*2/Win_ln;
Y = fft(est_x(1:wl));
P2 = abs(Y/wl);
P1 = P2(1:wl/2+1);
%P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(wl/2))/wl;
plot(f,140+(mag2db( P1))); hold on;
plot(f1,140+(mag2db(p1)));
xlim([0 2000 ])
title('Single-Sided Frequency Spectrum of X(t)')

xlabel('f (Hz)')
ylabel('Amplitude')
legend('DFT of lpc','DFT of original')