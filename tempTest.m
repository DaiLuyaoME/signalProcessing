%%
close all;
clear;
%% load data
data = csvread('./data/dataSet1/Raw_3.csv',2,1);
% data = csvread('./data/dataSet2/E8L029#04.csv',2,1);
fs = 49;
Ts = 1/fs;
numCol = size(data,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(data(:,i));
end
powerData = data(:,2);
% powerData = data(:,1);
figure;plot(powerData);
%% design filter
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
%%
powerData = powerData(1:end);
filteredPowerData = filter(dataFilter,powerData);
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('原始数据','低通滤波','零相位误差低通滤波');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);axis tight;
%% 计算电机功率特征
close all;
tempFlag = 2;
switch tempFlag
    case 1
        tempData = filteredPowerDataZeroPhaseError;
        dataName = '零相位滤波后数据';
    case 2
        tempData = filteredPowerData;
        dataName = '滤波后数据';
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 30;
methodType = 'MSD';

result = calCharacter(tempData,windowSize,startPoint,methodType);
% figure;plot([powerData,result]);

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
close all;
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
close all;
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
%% 不同窗口大小电机功率特征
close all;
tempFlag = 2;
switch tempFlag
    case 1
        tempData = filteredPowerDataZeroPhaseError;
        dataName = '零相位滤波后数据';
    case 2
        tempData = filteredPowerData;
        dataName = '滤波后数据';
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = floor(linspace(5,300,15));
% windowSize = 30;
num = numel(windowSize);
methodType = 'MIN';
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
xlim([500,numel(tempData)]);
%% 多数据文件电机功率特征分析
% 需要先执行loadData.m
close all;
tempFlag = 2;
num = numel(data);
tempData = cell(size(data));
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{i});
            dataName = '零相位滤波后数据';
        case 2
            tempData{i} = filter(dataFilter,data{i});
            dataName = '滤波后数据';
    end
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 30;
methodType = 'MSD';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize,startPoint,methodType);
end

figure;
for i = 1:num
    plot(result{i},'LineWidth',2);
    hold on;
end

ylabel(methodType);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
% legend('show');
xlim([500,3000]);
%% 多数据文件电机功率一阶导数特征分析
% 需要先执行loadData.m
close all;
tempFlag = 2;
num = numel(data);
tempData = cell(size(data));
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = diff(filtfilt(dataFilter,data{i}));
            dataName = '一阶导数（零相位滤波后）';
        case 2
            tempData{i} = diff(filter(dataFilter,data{i}));
            dataName = '一阶导数';
    end
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 100;
methodType = 'MIN';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize,startPoint,methodType);
end

figure;
for i = 1:num
    plot(result{i},'LineWidth',2);
    hold on;
end
hold on;
plot(zeros(1,3000),'DisplayName','0刻度线','LineWidth',2,'Color','black');
ylabel(methodType);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
% legend('show');
xlim([500,3000]);