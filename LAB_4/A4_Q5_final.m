
%%
% Global Variables Used
audio = "female_ishika.wav";
W_ms = 80;
Skip_ms = 30; %LEss than W_ms
Thresh_SE = 0.05;
%%
[SigTime,Fs] = audioread(audio);
SigTime = SigTime(1:end,1);
len = length(SigTime);
SqVal = SigTime.*SigTime;
Avg_SE = sum(SqVal)/len;
W_len = int32((W_ms/1000.0)*Fs);
Skip_len = int32((Skip_ms/1000.0)*Fs);
max =0;
VAD_SE = zeros(1,len);
for i = 1:Skip_len:len-W_len-5
    TSE = sum(SqVal(i:i+W_len) );
    TSE_avg = TSE / double(W_len);
    if TSE_avg >  Thresh_SE * Avg_SE
        VAD_SE(i:i+W_len)=1;
    end
end
W_len = 5000;
pitch_set = zeros(1,len);
for i = 1:Skip_len:len-W_len-5
    [x] = get_pitch(SigTime(i:i+W_len),Fs);
    
    pitch_set(i:i+W_len) = x*VAD_SE(i);
end
pitch_set(VAD_SE==0)=[];

pitch_set(pitch_set < 50) = 0;
pitch_set(pitch_set > 250) = 0;

allfrms = zeros(len,5);
for c = 1:Skip_len:len-W_len-1
    Sig = SigTime(c:c+W_len);
    frms = GetFrms(Sig,Fs);
    
    allfrms(c,1:5)= frms(1:5)*VAD_SE(c);
    
end
subplot(2,1,1);
spectrogram(SigTime,256,128,1024,Fs,'yaxis');
title('Spectrogram');
subplot(2,1,2);
plot( (1:length(allfrms) )/Fs,allfrms(:,1:2),'o');hold on;

plot((1:length(pitch_set) )/Fs,pitch_set,'o');
title('Pitch & Formant Contour');
xlabel('time in sec');
ylabel('Frequency (Hz)');
legend('Formant1','Formant2','pitch');





