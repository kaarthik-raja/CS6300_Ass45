%%
close all;
clear all;
clc;
%%
[y,Fs] = audioread('a.wav');
y = y(1:end,1);
max_y = max(abs(y));

Ts = 1/Fs;

%plot(y)
[acf,lags,bounds] = autocorr(y);
ta = (0:1:length(acf)-1)*1000;
figure()
plot(ta,acf);
max1=0;
  for uu=1:length(acf)
    if(acf(uu)>max1)
      max1=acf(uu);
      sample_no=uu;
    end
  end
 pitch_period_To=(20+sample_no)*(1/Fs);
 pitch_freq_Fo=1/pitch_period_To;
