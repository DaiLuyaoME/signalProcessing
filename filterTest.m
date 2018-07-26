dataFilter1 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
dataFilter2 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .004, 'PassbandRipple', 0.01);
dataFilter3 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
% dataFilter4 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
% fvtool(dataFilter1,dataFilter2,dataFilter3,dataFilter4);
fvtool(dataFilter1,dataFilter2,dataFilter3);
%%
% fs = 49;
% cutoffFrequency = 0.003;
cutoffFrequency = 0.003;
fs = 5000;
dataFilter1 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', cutoffFrequency, 'PassbandRipple', 0.01);
[b1,a1] = tf(dataFilter1);
[b2,a2] = secOrderFilter(cutoffFrequency/2 * fs, fs);
filterTemp1 = tf(b1,a1,1/fs);
filterTemp2 = tf(b2,a2,1/fs);
opts = bodeoptions;
opts.FreqUnits = 'Hz';
opts.PhaseMatching = 'on';
opts.PhaseMatchingFreq = 0.01;
opts.PhaseMatchingValue = 0;
figure;bodeplot(filterTemp1,filterTemp2,opts);
%%
b = ones(1,30)/30;
a = 1;
figure;
freqz(b,a);
%%
close all;
figure;fvtool(b,a,b1,a1)
%% 测试不同的滑动平均低通滤波器
b1 = ones(1,10)/10;
b2 = ones(1,30)/30;
b3 = ones(1,60)/60;
b4 = ones(1,120)/120;
b5 = ones(1,300)/300;
figure;fvtool(b1,1,b2,1,b3,1,b4,1,b5,1);
