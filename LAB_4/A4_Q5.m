%%
clear all;
close all;
clc;
%%
[y,Fs] = audioread('a.wav');
[pp,pf] = get_pitch(y,Fs);