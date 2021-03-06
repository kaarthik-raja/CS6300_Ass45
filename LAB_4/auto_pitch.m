%Program to find autocorrelation of a speech segment
[y,Fs]=audioread('female_ishika.wav');%input: speech segment

y = y(Fs*(2.3):Fs*(2.4),1);

yl = length(y);
%max_value=max(abs(y));
%y=y/max_value;
t=(1/Fs:1/Fs:(yl/Fs))*1000;
subplot(2,1,1);

plot(t,y);
title('Time Signal /female/')
xlim([0 100]);
hold on;
ylabel('Amplitude');
xlabel('time in milliseconds');
sum1=0;autocor=zeros(1,length(y));
   for l=0:(yl-1)
    sum1=0;
    for u=1:(yl-l)
      s=y(u)*y(u+l);
      sum1=sum1+s;
    end
    autocor(l+1)=sum1/(yl-l);
  end
kk=(1/Fs:1/Fs:(length(autocor)/Fs))*1000;
subplot(2,1,2);
%plot(t,y);hold on;

plot(kk,autocor);
title('Auto correlation /female/')
xlim([0 102]);
ylabel('Amplitude');
xlabel('time in milliseconds');
auto=autocor(21:yl);
  max1=0;
  for uu=1:(yl-20)
    if(auto(uu)>1.1*max1)
      max1=auto(uu);
      sample_no=uu;
    end
  end
  pitch_period_To=(20+sample_no)*(1/Fs);
  pitch_freq_Fo=1/pitch_period_To;
