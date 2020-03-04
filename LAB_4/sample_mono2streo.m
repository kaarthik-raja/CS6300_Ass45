[y,Fs] = audioread('a.wav');
y = y(1:end,1);
audiowrite('a1.wav',y,Fs);