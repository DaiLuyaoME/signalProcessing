%% 载入单个数据文件

% 载入数据集1的数据文件
% singleData = csvread('./data/dataSet1/Raw_3.csv',2,1);
% powerData = singleData(:,2);
% pos1 = singleData(:,3);
% pos2 = singleData(:,4);

% 载入数据集2的数据文件
singleData = csvread('./data/dataSet2/E8L030#13.csv',2,1);
powerData = singleData(:,1);
pos1 = singleData(:,2);
pos2 = singleData(:,3);

numCol = size(singleData,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(singleData(:,i));
end

figure;plot(powerData);
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
powerData = powerData(1:end);
filteredPowerData = filter(dataFilter,powerData);
% filteredPowerData = filter(b6,1,powerData);
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
% filteredPowerDataZeroPhaseError = filtfilt(b6,1,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('原始数据','低通滤波','零相位误差低通滤波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
% close all;
% tempFlag = 1, 计算零相位滤波后，电机功率特征； tempFlag = 2， 计算实时滤波后，电机功率特征；
tempFlag = 2;
switch tempFlag
    case 1
        tempData = filteredPowerDataZeroPhaseError;
        dataName = '零相位滤波后数据';
    case 2
        tempData = filteredPowerData;
        dataName = '滤波后数据';
end
startPoint = 300;
windowSize = 30;
methodType = 'MSD';
result = calCharacter(tempData,windowSize,startPoint,methodType);

%% 单组数据MSD 及其一阶导数分析
% 需要先运行tempTest，得到单组数据的MSD
deadtime = 1700;
tempResult = result;
figure;
yyaxis left;
plot(tempResult,'LineWidth',2,'DisplayName','死区后MSD');
xlabel('采样点');
ylabel('MSD');
hold on;
yyaxis right;
plot(diff(tempResult),'LineWidth',2,'displayname','MSD一阶导数');
hold on; plot(zeros(size(tempResult)),'LineWidth',2,'displayName','0刻度线','LineStyle','--','color','black');
ylabel('MSD一阶导数');
legend show;
xlim([deadtime,numel(tempResult)]);
set(gca,'fontsize',14);
% figure;findpeaks(tempResult);
%% 单组数据MSD极小值点抓取
deadtime = 1700;
[loc,val] = findNotch(result,0.1);
val = val(loc>deadtime);
loc = loc(loc>deadtime);
figure;
plot(result,'DisplayName','MSD','LineWidth',4);
hold on;
plot(loc,val,'o','linewidth',4);
xlim([deadtime,numel(result)]);
xlabel('采样点');
ylabel('MSD');
set(gca,'Fontsize',14);
%% 单组数据MSD极大值抓取
deadtime = 1700;
[loc,val] = findPeak(result,1);
val = val(loc>deadtime);
loc = loc(loc>deadtime);
figure;
plot(result,'DisplayName','MSD','LineWidth',4);
hold on;
plot(loc,val,'diamond','linewidth',4);
xlim([deadtime,numel(result)]);
xlabel('采样点');
ylabel('MSD');
set(gca,'Fontsize',14);
% %
% 多数据文件MSD极大值和极小值间距分析

%%  计算数据集全部文件
calMSDDistanceAndPeakValue;
%% 多数据文件实时滤波和零相位滤波极值点距离对比
% 该节代码需要先运行calMSDDistanceAndPeakValue.m脚本；
figure;
h = plot([disLoc1,disLoc2],'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('实时滤波','零相位滤波');
set(gca,'fontsize',14);
xlabel('数据文件编号');
ylabel('极值点距离  (单位：采样点个数)');
axis('tight');
figure;
h = errorbar([disLoc1,disLoc2], [disLoc1,disLoc2] - mean([disLoc1,disLoc2]),'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('实时滤波','零相位滤波');
set(gca,'fontsize',14);
xlabel('数据文件编号');
ylabel('极值点距离偏差  (单位：采样点个数)');
axis('tight');
%% 多数据文件实时滤波和零相位滤波极值点峰峰值
% 该节代码需要先运行calMSDDistanceAndPeakValue.m脚本；
figure;
h = plot([disVal1,disVal2],'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('实时滤波','零相位滤波');
set(gca,'fontsize',14);
xlabel('数据文件编号');
ylabel('MSD峰峰值');
axis('tight');
figure;
h = errorbar([disVal1,disVal2], [disVal1,disVal2] - mean([disVal1,disVal2]),'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('实时滤波','零相位滤波');
set(gca,'fontsize',14);
xlabel('数据文件编号');
ylabel('MSD峰峰值偏差');
axis('tight');
