function [modsigfft,fl,W] = nieitfft(Sig,Fs,NFFT)
% L=length(Sig);
% NFFT = 2^nextpow2(L); % Next power of 2 from length of y
modsigfft = fft(Sig,NFFT);
% modsigfft=modsigfft(1:NFFT/2);
fl = (0:1:NFFT/2-1)*Fs/NFFT; 
W = (0:1:NFFT/2-1)*2*pi/NFFT; 
% mx=abs(modsigfft);
% mx=mx/NFFT;
% mx=(2.*mx).^2;
% mxdbm=20.*log10(mx);
% mxang=angle(modsigfft);
end
