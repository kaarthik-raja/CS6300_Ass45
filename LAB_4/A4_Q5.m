%%
clear all;
close all;
clc;
%%
[y,Fs] = audioread('female_ishika.wav');
z = y(:,1);
spectrogram(z,256,128,1024,Fs,'yaxis');
set(gca, 'ylim', [0 5]);
[formants] = get_formants(y,Fs,60);
[pp,pf] = get_pitch(y,Fs);
