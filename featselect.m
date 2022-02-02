clc
clear all
close all

%input and target
load ('processinput.mat')
load ('target.mat')

%use relieff algorithm to obtain feature weights
[idx,weights]=relieff(processinput,target,10);

%plot the feature weights
figure(1)
plot(weights,'ro')
xlabel('Feature index')
ylabel('Feature weight')
grid on