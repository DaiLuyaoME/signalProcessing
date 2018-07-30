%% 多数据文件极大值极小值点标注
% 在图像上标注出极大值点极小值点，通过观察标注结果，确保正确地找到了所需要的极值点
clc;
% minHeight和maxHeight要根据窗口大小调节
minHeight = 1;
maxHeight = 0.4;
windowSize = 30;
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% 多数据文件MSD极大值和极小值间距分析
close all;
deadtime = 1700;
tempFlag = 1;
dataIndex = 1:75;
num = numel(dataIndex);
tempData = cell(num,1);

for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{dataIndex(i)});
            dataName = '零相位滤波后数据';
        case 2
            tempData{i} = filter(dataFilter,data{dataIndex(i)});
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

locMax  = zeros(numel(result),1);
valMax = zeros(numel(result),1);
locMin  = zeros(numel(result),1);
valMin = zeros(numel(result),1);

for i = 1:num
    [loc,val] = findPeak(result{i},minHeight);
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    locMax(i) = loc(1);
    valMax(i) = val(1);
     [loc,val] = findNotch(result{i},maxHeight);
    val = val(loc>locMax(i));
    loc = loc(loc>locMax(i));
    locMin(i) = loc(1);  
    valMin(i) = val(1);
end
%% 后处理
figure;
for i = 1:num
    plot(result{i},'LineWidth',2);
    hold on;
end
xlim([deadtime,3000]);
hold on;
plot(locMax,valMax,'diamond','LineWidth',3);
plot(locMin,valMin,'o','LineWidth',3);
xlabel('采样点');
ylabel('MSD');
set(gca,'fontsize',14);