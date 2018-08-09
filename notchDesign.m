% wo = 60/(300/2);  bw = wo/35;
% [b1,a1] = iirnotch(wo,wo/35);
% [b2,a2] = iirnotch(wo,wo/180,-20);
% fvtool(b1,a1,b2,a2);
close all;
%% 0.0156π处陷波器设计
wo = 0.0156;  bw = wo/3000;notchDepth = -60;
[b,a] = iirnotch(wo,bw,notchDepth);
fvtool(b,a);
% figure;bodeplot(tf(b,a));

%% 读取数据，对信号进行低通滤波
% 读取数据集2的一个数据文件
data = csvread('./data/dataSet2/E8L030#13.csv',2,1);
powerData = data(:,1);  % 电机功率信号
% 这里的滤波器截止频率选0.01π，这样0.0156π的共振峰就不会被充分削弱
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .01, 'PassbandRipple', 0.01);
% 实时滤波
filteredPowerData = filter(dataFilter,powerData); 
% 零相位滤波
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);

%% 原始信号陷波前后时域及功率谱对比
dataToFilt = filteredPowerDataZeroPhaseError;
% dataToFilt = filteredPowerData;
dataToFilt = powerData;
tempData1 = filtfilt(b,a,dataToFilt);
tempData2 = filter(b,a,dataToFilt);
% 陷波前后时域曲线
figure;
plot([dataToFilt,tempData1,tempData2],'LineWidth',2);
h = legend('原始数据','零相位误差陷波','陷波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;

% 陷波前后功率谱对比
figure;pwelch([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1),tempData2 - mean(tempData2)]);
h = legend('原始数据','零相位误差陷波','陷波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%% 实时滤波后信号陷波前后时域及功率谱对比
% dataToFilt = filteredPowerDataZeroPhaseError;
dataToFilt = filteredPowerData;
% dataToFilt = powerData;
tempData1 = filtfilt(b,a,dataToFilt);
tempData2 = filter(b,a,dataToFilt);
% 陷波前后时域曲线
figure;
plot([dataToFilt,tempData1,tempData2],'LineWidth',2);
h = legend('实时滤波后数据','零相位误差陷波','陷波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;

% 陷波前后功率谱对比
figure;pwelch([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1),tempData2 - mean(tempData2)]);
h = legend('实时滤波后数据','零相位误差陷波','陷波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%% 零相位滤波后信号陷波前后时域及功率谱对比
dataToFilt = filteredPowerDataZeroPhaseError;
% dataToFilt = filteredPowerData;
% dataToFilt = powerData;
tempData1 = filtfilt(b,a,dataToFilt);
tempData2 = filter(b,a,dataToFilt);
% 陷波前后时域曲线
figure;
plot([dataToFilt,tempData1,tempData2],'LineWidth',2);
h = legend('零相位滤波后数据','零相位误差陷波','陷波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;

% 陷波前后功率谱对比
figure;pwelch([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1),tempData2 - mean(tempData2)]);
h = legend('零相位滤波后数据','零相位误差陷波','陷波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;