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
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%%
num = numel(powerData);
figure;
for i = 500: 20 : num
    plot(filtfilt(dataFilter,powerData(1:i)),'LineWidth',2);
    hold on;
end
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%% “实时”零相位滤波时间计算
tic;
for i = 500: 20 : num
filtfilt(dataFilter,powerData(1:i));
end
toc;
%% 单次零相位滤波时间计算
tic;
filtfilt(dataFilter,powerData);
toc;