%Program to find autocorrelation of a speech segment
[y,Fs]=audioread('a.wav');%input: speech segment
max_value=max(abs(y));
y=y/max_value;
t=(1/Fs:1/Fs:(length(y)/Fs))*1000;
subplot(2,1,1);
plot(t,y);
xlabel('time in milliseconds');
sum1=0;autocor=zeros(1,length(y));
   for l=0:(length(y)-1)
    sum1=0;
    for u=1:(length(y)-l)
      s=y(u)*y(u+l);
      sum1=sum1+s;
    end
    autocor(l+1)=sum1;
  end
kk=(1/Fs:1/Fs:(length(autocor)/Fs))*1000;
subplot(2,1,2);
plot(kk,autocor);
xlabel('time in milliseconds');
auto=autocor(21:160);
  max1=0;
  for uu=1:length(auto)
    if(auto(uu)>max1)
      max1=auto(uu);
      sample_no=uu;
    end
  end
  pitch_period_To=(sample_no)*(1/Fs);
  pitch_freq_Fo=1/pitch_period_To;
