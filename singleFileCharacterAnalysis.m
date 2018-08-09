%%
close all;
clear;
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

fs = 39;
Ts = 1/fs;

numCol = size(singleData,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(singleData(:,i));
end

figure;plot(powerData);
%% 滤波器设计
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% 对信号进行滤波
powerData = powerData(1:end);
filteredPowerData = filter(dataFilter,powerData);
% filteredPowerData = filter(b6,1,powerData);
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
% filteredPowerDataZeroPhaseError = filtfilt(b6,1,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('原始数据','低通滤波','零相位误差低通滤波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%% 计算电机功率特征
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

% 计算起始点位置
startPoint = 300;
% 计算用的窗口大小
windowSize = 30;
% 计算的特征，‘MSD’时技术算MSD，‘MA’时计算MA
methodType = 'MSD';
% 计算特征
result = calCharacter(tempData,windowSize,startPoint,methodType);

% 单独绘制MSD
figure;
plot(result,'DisplayName','MSD','LineWidth',2);
xlim([500,numel(tempData)]);

% 绘制MSD，电机原始功率、滤波后功率
figure;
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(tempData,'DisplayName',dataName,'LineWidth',2,'Color','black'); ylabel('电机功率');
yyaxis right;
plot(result,'DisplayName',methodType,'LineWidth',2);
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0刻度线');
ylabel(methodType);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
legend('show');
xlim([500,numel(tempData)]);
%% 计算电机功率信号一阶导数特征
% close all;
% tempFlag = 1, 计算零相位滤波后，电机功率特征； tempFlag = 2， 计算实时滤波后，电机功率特征；
tempFlag = 2;
switch tempFlag
    case 1
        tempData = diff(filteredPowerDataZeroPhaseError);
        tempFilterData = filteredPowerDataZeroPhaseError;
        dataName = '一阶导数（零相位滤波后）';
        tempFilterDataName = '缩放后零相位滤波后数据';
    case 2
        tempData = diff(filteredPowerData);
        tempFilterData = filteredPowerData;
        dataName = '一阶导数';
        tempFilterDataName = '缩放后滤波后数据';
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 30;
methodType = 'MSD';

result = calCharacter(tempData,windowSize,startPoint,methodType);
% figure;plot([powerData,result]);

figure;
yyaxis left;
% tempRatio = max(abs(tempData)) / max(abs(tempFilterData)) ;
% plot(tempRatio*powerData,'DisplayName','缩放后原始数据');
% hold on ;
% plot(tempRatio*tempFilterData,'DisplayName',tempFilterDataName,'LineWidth',2,'Color','black'); ylabel('电机功率一阶导数');
plot(tempData,'DisplayName',dataName,'LineWidth',2);
hold on;
plot(zeros(size(tempData)),'DisplayName','0刻度线','LineWidth',4,'Color','black');
ylabel('电机功率一阶导数');
yyaxis right;
plot(result,'DisplayName',methodType,'LineWidth',2);
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0刻度线');
ylabel(methodType);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'northwest';
xlim([500,numel(tempData)]);
%% 计算电机功率信号二阶导数特征
% close all;
% tempFlag = 1, 计算零相位滤波后，电机功率特征； tempFlag = 2， 计算实时滤波后，电机功率特征；
tempFlag = 1;
switch tempFlag
    case 1
        tempData = diff(filteredPowerDataZeroPhaseError,2);
        tempFilterData = filteredPowerDataZeroPhaseError;
        dataName = '二阶导数（零相位滤波后）';
        tempFilterDataName = '缩放后零相位滤波后数据';
    case 2
        tempData = diff(filteredPowerData,2);
        tempFilterData = filteredPowerData;
        dataName = '二阶导数';
        tempFilterDataName = '缩放后滤波后数据';
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 30;
methodType = 'MSD';

result = calCharacter(tempData,windowSize,startPoint,methodType);
% figure;plot([powerData,result]);

figure;
yyaxis left;
% tempRatio = max(abs(tempData)) / max(abs(tempFilterData)) ;
% plot(tempRatio*powerData,'DisplayName','缩放后原始数据');
% hold on ;
% plot(tempRatio*tempFilterData,'DisplayName',tempFilterDataName,'LineWidth',2,'Color','black'); ylabel('电机功率一阶导数');
plot(tempData,'DisplayName',dataName,'LineWidth',2);
hold on;
plot(zeros(size(tempData)),'DisplayName','0刻度线','LineWidth',4,'Color','black');
ylabel('电机功率二阶导数');
yyaxis right;
plot(result,'DisplayName',methodType,'LineWidth',2);
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0刻度线');
ylabel(methodType);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'northwest';
xlim([500,numel(tempData)]);
%% 计算不同窗口大小下，同一数据文件电机功率特征变化情况
% close all;
% tempFlag = 1, 计算零相位滤波后，电机功率特征； tempFlag = 2， 计算实时滤波后，电机功率特征；
tempFlag = 2;
switch tempFlag
    case 1
        tempData = filteredPowerDataZeroPhaseError;
        dataName = '零相位滤波后数据';
    case 2
        tempData = filteredPowerData;
        dataName = '实时滤波后数据';
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = floor(linspace(5,300,10));
num = numel(windowSize);
methodType = 'MSD';
result = zeros(numel(tempData),num);
nameCell = cell(num,1);
for i = 1:num
    tempSize = windowSize(i);
    result(:,i) = calCharacter(tempData,tempSize,startPoint,methodType);
    nameCell{i} = sprintf('%d',tempSize);
    % figure;plot([powerData,result]);
end
figure;
plot(result,'LineWidth',2);
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0刻度线');
ylabel([dataName,methodType]);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
legend(nameCell);
xlim([1700,numel(tempData)]);
