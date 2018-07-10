% wo = 60/(300/2);  bw = wo/35;
% [b1,a1] = iirnotch(wo,wo/35);
% [b2,a2] = iirnotch(wo,wo/180,-20);
% fvtool(b1,a1,b2,a2);
close all;
%%
% wo = 0.01514;  bw = wo/3000;notchDepth = -60;
% [b,a] = iirnotch(wo,bw,notchDepth);
% fvtool(b,a);
% figure;bodeplot(tf(b,a));
%%
wo = 0.47;  bw = wo/3000;notchDepth = -60;
[b,a] = iirnotch(wo,bw,notchDepth);
fvtool(b,a);
%%
dataToFilt = filteredPowerDataZeroPhaseError;
% dataToFilt = filteredPowerData;
dataToFilt = powerData;
tempData1 = filtfilt(b,a,dataToFilt);
tempData2 = filter(b,a,dataToFilt);
figure;
plot([dataToFilt,tempData1,tempData2],'LineWidth',2);
h = legend('原始数据','零相位误差陷波','陷波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%%
figure;pwelch([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1),tempData2 - mean(tempData2)]);
h = legend('原始数据','零相位误差陷波','陷波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
% pwelch([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1)]);
% figure;periodogram([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1)]);
% figure;pmtm([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1)]);