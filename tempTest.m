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
powerData = powerData(1:end);
filteredPowerData = filter(dataFilter,powerData);
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('原始数据','低通滤波','零相位误差低通滤波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%%
tempData = filteredPowerDataZeroPhaseError;
% tempData = filteredPowerData;
startPoint = 300;
windowSize = 30;
methodType = 'mean';

result = calCharacter(tempData,windowSize,startPoint,methodType);
% figure;plot([powerData,result]);

figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(tempData,'DisplayName','滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(result,'DisplayName',methodType,'LineWidth',2,'Color','black');
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0刻度线');
ylabel(methodType);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;

