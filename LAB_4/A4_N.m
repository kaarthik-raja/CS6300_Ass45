clear all;
close all;
clc;
%%

N = 1024;
[x,Fs] = audioread("a.wav");
x = x(1:end,1);
l = 1024;
%noise = randn(50000,1);
%x = filter(1,[1 1/2 1/3 1/4],noise);
%x = x(end-4096+1:end);
%Fs = 16000;
x = x(1:N,1);
%x = x + randn(N,1)*mean(abs(x))*0.5;
[a,e] = lpc(x,12);
%plot(a);
est_x = filter([0 -a(2:end)],1,x);
e = x - est_x;


%[d,f,w] = nieitfft(est_x,Fs,N);
%[d0,f0,w0] = nieitfft(x,Fs,N);
%plot(abs(d(1:N))/N ,f);grid on;
 
%figure
plot(1:1000,x(end-1000+1:end),1:1000,est_x(end-1000+1:end),'--')
grid on;
[dft0,f0,w0] = nieitfft(x,Fs,l);
[dft1,f1,w1] = nieitfft(est_x,Fs,l);
figure
plot(f0,mag2db(abs(dft0(1:l/2)))); hold on;
plot(f1,mag2db(abs(dft1(1:l/2))),'--');
xlim([0 3000]);
%xlabel('Sample Number')
%ylabel('Amplitude')
%legend('Original signal','LPC estimate')

t = l/2;
S = zeros(1,l/2);
f = Fs*(1:(l/2))/l;
for k=1:l/2
    for p=1:12
        S(k) = S(k) + a(p)*exp(-1i*f(k)*p);
    end
    S(k) = 1/(1-S(k));
end
figure   
plot(f,abs((S(1:t))/t));
xlim([0 3000]);