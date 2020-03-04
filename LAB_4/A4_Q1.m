clear all;
clear all;
clc;
%%
Win_ln = 25600;
audio = "a.wav";

frm = "a.frm";

[SigTime,Fs] = audioread(audio);
SigTime = SigTime(1:end,1);
skip_val = 15;
index = (1:skip_val:length(SigTime));
Fs = Fs / skip_val;
SigTime = SigTime(index);
Win_ln = length(SigTime);
[a,e] = lpc(SigTime,1000);
rts = roots(a);

rts = rts(imag(rts)>=0);
angz = atan2(imag(rts),real(rts));

[frqs,indices] = sort(angz.*(Fs/(2*pi)));
bw = -1/2*(Fs/(2*pi))*log(abs(rts(indices)));

formants = zeros(1,length(frqs));
nn = 1;
for kk = 1:length(frqs)
    if (frqs(kk) > 600 && bw(kk) <400)
        formants(nn) = frqs(kk);
        nn = nn+1;
    end
end

est_x = filter([0 -a(2:end)],1,SigTime);
plot(SigTime);
hold on;
plot(est_x);
figure()
wl = Win_ln;
y = fft(SigTime);
p2 = abs(y/Win_ln);
p1 = p2(1:Win_ln/2+1);
f1 = Fs*(0:(Win_ln/2))/Win_ln;
Y = fft(est_x(1:wl));
P2 = abs(Y/wl);
P1 = P2(1:wl/2+1);
%P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(wl/2))/wl;
plot(f,(mag2db( P1))); hold on;
plot(f1,(mag2db(p1)));
xlim([0 3000 ])
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')