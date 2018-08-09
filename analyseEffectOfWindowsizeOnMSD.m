%% 分析不同窗口大小对极值点距离、峰峰值和延时的影响

%% 载入数据集中全部数据文件
loadData;
%% 清除相关变量；
clear disLoc1;
clear disLoc2;
clear valLoc1;
clear valLoc2;
clear minLocRealTime;
clear minLocZeroPhase;
clc;
%% 设置相关参数
% minHeight和maxHeight要根据窗口大小调节
clear windowSize;
windowSize{1} = 30;
windowSize{2} = 60;
windowSize{3} = 90;
windowSize{4} = 120;
clear minHeight;
clear maxHeight;
minHeight = {0.6,1,2,3};
maxHeight = {0.1,0.6,2,3};
clear dataFilter;
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);

%% 多数据文件MSD极大值和极小值间距分析
for k = 1:4
deadtime = 1700;
tempFlag = 2;
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
result{i} = calCharacter(tempData{i},windowSize{k},startPoint,methodType);
% result{i} = calCharacterVariedWeight(tempData{i},windowSize{k},startPoint,methodType);
end

distanceLoc  = zeros(numel(result),1);
distanceVal = zeros(numel(result),1);

for i = 1:num
    [loc,val] = findPeak(result{i},minHeight{k});
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    loc1 = loc(1);
    val1 = val(1);
     [loc,val] = findNotch(result{i},maxHeight{k});
    val = val(loc>loc1);
    loc = loc(loc>loc1);
    loc2 = loc(1);  
    val2 = val(1);
    distanceLoc(i) = loc2 - loc1;
    distanceVal(i) = val1 - val2;
    minLocRealTime(i,k) = loc2;
end
% figure;
% plot(distanceLoc);
% figure;plot(distanceVal);
disLoc1{k} = distanceLoc;
valLoc1{k} = distanceVal;
%% 多数据文件MSD极大值和极小值间距分析
deadtime = 1700;
tempFlag = 1;
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
result{i} = calCharacter(tempData{i},windowSize{k},startPoint,methodType);
% result{i} = calCharacterVariedWeight(tempData{i},windowSize{k},startPoint,methodType);

end

distanceLoc  = zeros(numel(result),1);
distanceVal = zeros(numel(result),1);

for i = 1:num
    [loc,val] = findPeak(result{i},minHeight{k});
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    loc1 = loc(1);
    val1 = val(1);
     [loc,val] = findNotch(result{i},maxHeight{k});
    val = val(loc>loc1);
    loc = loc(loc>loc1);
    loc2 = loc(1);  
    val2 = val(1);
    distanceLoc(i) = loc2 - loc1;
    distanceVal(i) = val1 - val2;
    minLocZeroPhase(i,k) = loc2;
end
% figure;
% plot(distanceLoc);
% figure;plot(distanceVal);
disLoc2{k} = distanceLoc;
valLoc2{k} = distanceVal;

end

%% 后处理 极值点距离
tempDataPlot = cell2mat(disLoc1);
figure;
h = plot(tempDataPlot,'LineWidth',2);
h(1).DisplayName = '窗口大小30';
h(2).DisplayName = '窗口大小60';
h(3).DisplayName = '窗口大小90';
h(4).DisplayName = '窗口大小120';
h(1).Marker = 'diamond';
h(2).Marker = '*';
h(3).Marker = 'o';
h(4).Marker = '+';
xlabel('数据文件编号');
ylabel('极值点距离');
legend('show');
set(gca,'fontsize',14);
axis tight;
%% 后处理 峰峰值
tempDataPlot = cell2mat(valLoc1);
figure;
h = plot(tempDataPlot,'LineWidth',1);
h(1).DisplayName = '窗口大小30';
h(2).DisplayName = '窗口大小60';
h(3).DisplayName = '窗口大小90';
h(4).DisplayName = '窗口大小120';
h(1).Marker = 'diamond';
h(2).Marker = '*';
h(3).Marker = 'o';
h(4).Marker = '+';
xlabel('数据文件编号');
ylabel('MSD峰峰值');
legend('show');
set(gca,'fontsize',14);
axis tight;
%% 后处理 延时
figure;
load minValPos.mat;
% h = plot(minLocRealTime - minValPos,'LineWidth',2);
h = plot(minLocZeroPhase - minValPos,'LineWidth',2);
h(1).DisplayName = '窗口大小30';
h(2).DisplayName = '窗口大小60';
h(3).DisplayName = '窗口大小90';
h(4).DisplayName = '窗口大小120';
h(1).Marker = 'diamond';
h(2).Marker = '*';
h(3).Marker = 'o';
h(4).Marker = '+';
xlabel('数据文件编号');
ylabel('延时（单位：数据点）');
legend('show');
set(gca,'fontsize',14);
axis tight;