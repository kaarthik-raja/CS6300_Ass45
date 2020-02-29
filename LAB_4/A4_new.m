clear all;
close all;
clc;
%%

[SigTime,Fs] = audioread("a1.wav");

l = length(SigTime);

a = lpc(SigTime,20);

est_x = filter(1,[0 -a(2:end)],SigTime)
plot(est_x);hold on;
plot(SigTime);
