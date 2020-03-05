clear all;
clear all;
clc;
%%
% Global Variables Used
audio = "sa2.F.wav";
W_ms = 80;
Skip_ms = 30; %LEss than W_ms
Thresh_ZC = 0.7;
Thresh_SE = 0.05;
%%
[SigTime,Fs] = audioread(audio);
SigTime = SigTime(1:end,1);
len = length(SigTime);

SqVal = SigTime.*SigTime;
ZC = sign(-SigTime(1:end-1).*SigTime(2:end));
ZC(ZC<0) = 0 ;

%figure;
%dscatter(1:len-1,ZC);
%colorbar;

Avg_ZC = sum(ZC)/len;
Avg_SE = sum(SqVal)/len;


fprintf("Avg Zero Crossing = %d, Energy = %d\n",Avg_ZC,Avg_SE);

W_len = int32((W_ms/1000.0)*Fs);
Skip_len = int32((Skip_ms/1000.0)*Fs);
ZC_Win = Avg_ZC*W_len;
max =0;
VAD_ZC = zeros(1,len);
VAD_SE = zeros(1,len);
for i = 1:Skip_len:len-W_len-5
    TZC = sum(ZC(i:i+W_len) );
    TZC_avg = TZC/double(W_len);
    TSE = sum(SqVal(i:i+W_len) );
    TSE_avg = TSE / double(W_len);
    
    if (TZC_avg < Thresh_ZC*Avg_ZC)
        VAD_ZC(i:i+W_len)=1;
    end
    if TSE_avg >  Thresh_SE * Avg_SE
        VAD_SE(i:i+W_len)=1;
    end
end
figure;
subplot(3,1,1);
plot(1:len , VAD_ZC,'LineWidth',1.25);
subplot(3,1,2);
plot(1:len , VAD_SE,'LineWidth',1.25)
subplot(3,1,3);
plot(1:len,SigTime)
