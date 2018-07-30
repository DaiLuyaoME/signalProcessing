%% 多数据文件极大值极小值点标注
% 寻找数据2极小值点的准确位置
clc;
% minHeight和maxHeight要根据窗口大小调节
minHeight = 1;
maxHeight = 1000;
windowSize = 30;
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% 多数据文件MSD极大值和极小值间距分析
close all;
deadtime = 1700;
tempFlag = 1;% 因为要找准确位置，因此要采用零相位滤波
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

for i = 1:num
    [loc,val] = findNotch(tempData{i},maxHeight);
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    locMin(i) = loc(1);  
    valMin(i) = val(1);
end
%% 后处理
figure;
for i = 1:num
    plot(tempData{i},'LineWidth',2);
    hold on;
end
xlim([deadtime,3000]);
hold on;
plot(locMin,valMin,'o','LineWidth',3);
xlabel('采样点');
ylabel('MSD');
set(gca,'fontsize',14);