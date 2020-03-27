clear all;
clear all;
clc;

%%
%Global Vars
audio = "./LAB_4/e.wav";
W_len = 1024;
Skip_len = 100;

%%
[SigTime,Fs] = audioread(audio);
SigTime = SigTime(1:end,1);
len = length(SigTime);
allfrms = zeros(len,5);
j=0;
for c = 1:Skip_len:len-W_len-1
    j=j+1;
    Sig = SigTime(c:c+W_len);
    frms = GetFrms(Sig,Fs);
    
    allfrms(j,1:5)= frms(1:5);
    
end

plot(1:500,allfrms(1:500,1));hold on;
plot(1:500,allfrms(1:500,2));hold on;
plot(1:500,allfrms(1:500,3));
legend('formant 1','formant 2','formant 3')
title('Formant Contour using LPC /e/');
xlabel('Time Samples');
ylabel('Frequency (Hz)');
