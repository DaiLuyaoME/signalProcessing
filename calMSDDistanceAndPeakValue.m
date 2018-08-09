%% MSD极大值和极小值距离和峰峰值计算

%% 清除相关变量
clear disLoc1; % disLoc1存储实时滤波时，MSD极大值极小值距离
clear disLoc2; % disLoc2存储零相位滤波时，MSD极大值极小值距离
clear disVal1; % disVal1存储实时滤波时，MSD峰峰值
clear disVal2; % disVal2存储零相位滤波时，MSD峰峰值
clc;
%% 载入数据集中全部数据文件
loadData;
%% 设定阈值
% minHeight和maxHeight要根据窗口大小调节
minHeight = 0.8; % 极大值阈值
maxHeight = 0.3; % 极小值阈值
windowSize = 30;
%% 设计滤波器
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% 多数据文件MSD极大值和极小值距离分析
close all;
deadtime = 1700;
tempFlag = 2; % 采用实时滤波
num = numel(data);
tempData = cell(size(data));

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

methodType = 'MSD';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize,startPoint,methodType);
end

distanceLoc  = zeros(numel(result),1);
distanceVal = zeros(numel(result),1);

for i = 1:num
    [loc,val] = findPeak(result{i},minHeight);
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    loc1 = loc(1);
    val1 = val(1);
     [loc,val] = findNotch(result{i},maxHeight);
    val = val(loc>loc1);  % 在找到第一个MSD极大值点后，才允许检测极小值点
    loc = loc(loc>loc1);
    loc2 = loc(1);  
    val2 = val(1);
    distanceLoc(i) = loc2 - loc1; % 极大值和极小值距离
    distanceVal(i) = val1 - val2; % 极大值和极小值之差，即峰峰值
end
% figure;
% plot(distanceLoc);
figure;plot(distanceVal);
disLoc1 = distanceLoc;
disVal1 = distanceVal;
%% 多数据文件MSD极大值和极小值间距分析
close all;
deadtime = 1700;
tempFlag = 1; % 采用零相位滤波
num = numel(data);
tempData = cell(size(data));
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
% windowSize = 30;
methodType = 'MSD';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize,startPoint,methodType);
end

distanceLoc  = zeros(numel(result),1);
distanceVal = zeros(numel(result),1);

for i = 1:num
    [loc,val] = findPeak(result{i},minHeight);
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    loc1 = loc(1);
    val1 = val(1);
     [loc,val] = findNotch(result{i},maxHeight);
    val = val(loc>loc1);
    loc = loc(loc>loc1);
    loc2 = loc(1);  
    val2 = val(1);
    distanceLoc(i) = loc2 - loc1;
    distanceVal(i) = val1 - val2;
end
% figure;
% plot(distanceLoc);
figure;plot(distanceVal);
disLoc2 = distanceLoc;
disVal2 = distanceVal;

