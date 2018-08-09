%% 关闭所有绘图，清除所有变量
close all;
clear;
%% 读取数据
% 注意，数据集1和数据集2的数据排列顺序有区别，因此第9行代码和第13行代码采用了不同的数据索引

% 读取数据集1的一个数据文件
% data = csvread('./data/dataSet1/Raw_5.csv',2,1);
% powerData = data(:,2); %电机功率信号

% 读取数据集2的一个数据文件
data = csvread('./data/dataSet2/E8L030#13.csv',2,1);
powerData = data(:,1);  % 电机功率信号

%% 定义采样频率与采样周期
fs = 39;
Ts = 1/fs;
%% 绘制电机功率、往复位置和摆动角度
numCol = size(data,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(data(:,i));
end
%% 单独绘制电机功率信号
figure;plot(powerData,'LineWidth',1,'DisplayName','原始数据');xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%% 分析原始电机功率信号频谱
tempData = powerData(1:end);
% 分析功率谱之前需要先减去平均值以排除直流分量的影响
powerDataMeaned = tempData - mean(tempData);
% type = 1, 归一化功率谱（即频率为归一化频率）； type = 2， 真实频率功率谱
type = 1;
switch type
    case 1
        % Welch方法
        figure;  pwelch(powerDataMeaned);
        [pxx,f] = pwelch(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱Welch');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        % 周期图法
        figure;periodogram(powerDataMeaned);
        [pxx,f] = periodogram(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱周期图');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        % Tomson方法
        figure;pmtm(powerDataMeaned);
        [pxx,f] = pmtm(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('归一化累积功率谱Thomson方法');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
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

%% 设计滤波器
% 请参考MATLAB自带帮助文档了解designfilt函数的使用说明
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% 对电机功率信号进行滤波
% 实时滤波
filteredPowerData = filter(dataFilter,powerData); 
% 零相位滤波
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
% filteredPowerDataZeroPhaseError = filtfilt(b6,1,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('原始数据','低通滤波','零相位误差低通滤波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%% 滤波后功率谱与累积功率谱
figure; pwelch(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('零相位滤波后功率谱估计Welch方法')
figure; pwelch(filteredPowerData - mean(filteredPowerData));title('滤波后功率谱估计Welch方法');
[pxx,f] = pwelch(filteredPowerData-mean(filteredPowerData));
figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('累积功率谱Welch');
%% 计算实时滤波和零相位滤波后的一阶导数和二阶导数
originalData = filteredPowerData;
firDev = diff(originalData);
secDev = diff(originalData,2);
originalDataZeroPhase = filteredPowerDataZeroPhaseError;
firDevZeroPhase = diff(originalDataZeroPhase);
secDevZeroPhase = diff(originalDataZeroPhase,2);
num = numel(secDevZeroPhase);
%% 绘制一阶导数
% 零相位滤波一阶导数绘制
figure;
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(originalDataZeroPhase,'DisplayName','零相位误差滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(firDevZeroPhase,'DisplayName','一阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(firDevZeroPhase)),'DisplayName','0刻度线','LineWidth',4,'Color','black');
ylabel('一阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'northwest';
xlim([500,numel(powerData)]);
% 实时滤波一阶导数绘制
figure;
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(originalData,'DisplayName','滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(firDev,'DisplayName','一阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(firDev)),'DisplayName','0刻度线','LineWidth',4,'Color','black');
ylabel('一阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'northwest';
xlim([500,numel(powerData)]);

%% 绘制二阶导数
% 零相位滤波二阶导数绘制
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
xlim([1000,numel(powerData)]);
% 实时滤波二阶导数绘制
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
xlim([1000,numel(powerData)]);

