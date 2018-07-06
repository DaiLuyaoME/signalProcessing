% wo = 60/(300/2);  bw = wo/35;
% [b1,a1] = iirnotch(wo,wo/35);
% [b2,a2] = iirnotch(wo,wo/180,-20);
% fvtool(b1,a1,b2,a2);
close all;
%%
wo = 0.01514;  bw = wo/3000;notchDepth = -60;
[b,a] = iirnotch(wo,bw,notchDepth);
fvtool(b,a);
%%
dataToFilt = filteredPowerDataZeroPhaseError;
% tempData = filter(b,a,dataToFilt);
tempData = filtfilt(b,a,dataToFilt);
figure;
plot([dataToFilt,tempData]);
%%
figure;pwelch([dataToFilt - mean(dataToFilt),tempData - mean(tempData)]);
figure;periodogram([dataToFilt - mean(dataToFilt),tempData - mean(tempData)]);
figure;pmtm([dataToFilt - mean(dataToFilt),tempData - mean(tempData)]);