function[pitch_period_To,pitch_freq_Fo] = get_pitch(y,Fs)
y = y(1:5000,1);
yl = length(y);
%max_value=max(abs(y));
%y=y/max_value;

autocor=zeros(1,length(y));
   for l=0:(yl-1)
    sum1=0;
    for u=1:(yl-l)
      s=y(u)*y(u+l);
      sum1=sum1+s;
    end
    autocor(l+1)=sum1/(yl-l);
  end

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
