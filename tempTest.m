%%
close all;
clear;
%% load data
% data = csvread('./data/dataSet1/Raw_5.csv',2,1);
data = csvread('./data/dataSet2/E8L029#04.csv',2,1);
fs = 49;
Ts = 1/fs;
numCol = size(data,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(data(:,i));
end
% powerData = data(:,2);
powerData = data(:,1);
figure;plot(powerData);
%% design filter
dataFilter = designfilt('lowpassiir', 'FilterOrder', 5, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%%
powerData = powerData(1:end);
filteredPowerData = filter(dataFilter,powerData);
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('原始数据','低通滤波','零相位误差低通滤波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;