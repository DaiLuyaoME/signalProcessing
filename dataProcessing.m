%%
close all;
clear;
%% load data
% data = csvread('./data/dataSet1/Raw_5.csv',2,1);
data = csvread('./data/dataSet2/E8L029#04.csv',2,1);
%%
fs = 49;
Ts = 1/fs;
%%
numCol = size(data,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(data(:,i));
end
%%
% powerData = data(:,2);
powerData = data(:,1);
figure;plot(powerData,'LineWidth',1,'DisplayName','原始数据');xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
% powerData = powerData(abs(powerData)>threshold);
threshold = 1;
powerData = powerData(threshold:end);

%%
tempData = powerData(1:end);
powerDataMeaned = tempData - mean(tempData);

type = 1; % 1 for normalized; 2 for authenticate;
switch type
    case 1
        figure;  pwelch(powerDataMeaned);
%         plot(f,10*log10(pxx),'LineWidth',2);
%         xlabel('Normalized Frequency  (\times\pi rad/sample)');
%         ylabel('Power/frequency (dB/rad/sample)');
        [pxx,f] = pwelch(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱Welch');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure;periodogram(powerDataMeaned);
        [pxx,f] = periodogram(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱周期图');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure;pmtm(powerDataMeaned);
        [pxx,f] = pmtm(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱Thomson方法');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure; pmusic(powerDataMeaned,14);
    case 2
        
        
        figure;pwelch(powerDataMeaned,1000,500,1000,fs);
        [pxx,f] = pwelch(powerDataMeaned,1000,500,1000,fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('累积功率谱Welch');
        
        figure;periodogram(powerDataMeaned,[],[],fs);
        [pxx,f] = periodogram(powerDataMeaned,[],[],fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('累积功率谱周期图');
        
        figure;pmtm(powerDataMeaned,[],[],fs);
        [pxx,f] = pmtm(powerDataMeaned,[],[],fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('累积功率谱Thomson方法');
        
end

%%
powerData = powerData(1:end);
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
% dataFilter = designfilt('lowpassfir', 'FilterOrder', 17, 'PassbandFrequency', .05, 'StopbandFrequency', 0.06);
filteredPowerData = filter(dataFilter,powerData);
figure;plot([powerData,filteredPowerData]);
%%
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',4);
h = legend('原始数据','低通滤波','零相位误差低通滤波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
% [tempx,tempy] = ginput(2);
%%
figure; pwelch(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('零相位滤波后功率谱估计Welch方法')
figure; pwelch(filteredPowerData - mean(filteredPowerData));title('滤波后功率谱估计Welch方法');
% figure; periodogram(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('滤波后功率谱估计周期图方法');
% figure;[pxx,f] = periodogram(filteredPowerDataZeroPhaseError,[],[],fs);title('滤波后功率谱估计周期图方法');
%%
figure;plot(diff(filteredPowerDataZeroPhaseError));
figure;plot(diff(diff(filteredPowerDataZeroPhaseError)));
%%
% originalData = filteredPowerData;
originalData = filteredPowerData;
firDev = diff(originalData);
secDev = diff(originalData,2);
originalDataZeroPhase = filteredPowerDataZeroPhaseError;
firDevZeroPhase = diff(originalDataZeroPhase);
secDevZeroPhase = diff(originalDataZeroPhase,2);
num = numel(secDevZeroPhase);
%% 一阶导数绘制
figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(originalDataZeroPhase,'DisplayName','零相位误差滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(firDevZeroPhase,'DisplayName','一阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(firDevZeroPhase)),'DisplayName','0刻度线');
ylabel('一阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(originalData,'DisplayName','滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(firDev,'DisplayName','一阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(firDev)),'DisplayName','0刻度线');
ylabel('一阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

%% 二阶导数绘制
figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(originalDataZeroPhase,'DisplayName','零相位误差滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(secDevZeroPhase,'DisplayName','二阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(secDevZeroPhase)),'DisplayName','0刻度线');
ylabel('二阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';
figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(originalDataZeroPhase,'DisplayName','滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(secDev,'DisplayName','二阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(secDev)),'DisplayName','0刻度线');
ylabel('二阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

%% 滤波后频谱分析，带采样频率

tempData = filteredPowerDataZeroPhaseError(40:end);
% tempData = filteredPowerData(1:end);
figure;plot(tempData);
powerDataMeaned = tempData - mean(tempData);

type = 1; % 1 for normalized; 2 for authenticate;
switch type
    case 1
        figure;  pwelch(powerDataMeaned);
%         plot(f,10*log10(pxx),'LineWidth',2);
%         xlabel('Normalized Frequency  (\times\pi rad/sample)');
%         ylabel('Power/frequency (dB/rad/sample)');
        [pxx,f] = pwelch(powerDataMeaned);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱Welch');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure;periodogram(powerDataMeaned);
        [pxx,f] = periodogram(powerDataMeaned);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱周期图');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure;pmtm(powerDataMeaned);
        [pxx,f] = pmtm(powerDataMeaned);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱Thomson方法');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');        
        figure; pmusic(powerDataMeaned,14);
    case 2      
        figure;pwelch(powerDataMeaned,1000,500,1000,fs);
        [pxx,f] = pwelch(powerDataMeaned,1000,500,1000,fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('累积功率谱Welch');
        
        figure;periodogram(powerDataMeaned,[],[],fs);
        [pxx,f] = periodogram(powerDataMeaned,[],[],fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('累积功率谱周期图');
        
        figure;pmtm(powerDataMeaned,[],[],fs);
        [pxx,f] = pmtm(powerDataMeaned,[],[],fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('累积功率谱Thomson方法');
        
end
