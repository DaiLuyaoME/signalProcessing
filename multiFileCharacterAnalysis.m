%% 载入数据集中全部数据文件
loadData;
%% 多数据文件电机功率特征分析
% tempFlag = 1, 计算零相位滤波后，电机功率特征； tempFlag = 2， 计算实时滤波后，电机功率特征；
tempFlag = 2;
num = numel(data);
tempData = cell(size(data));
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{i});
            dataName = '零相位滤波后';
        case 2
            tempData{i} = filter(dataFilter,data{i});
            dataName = '实时滤波后';
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
title([dataName,'电机功率MSD']);
ylabel(methodType);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
% legend('show');
xlim([500,3000]);
%% 多数据文件电机功率一阶导数特征分析
% tempFlag = 1, 计算零相位滤波后，电机功率特征； tempFlag = 2， 计算实时滤波后，电机功率特征；
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
hold on;
plot(zeros(1,3000),'DisplayName','0刻度线','LineWidth',2,'Color','black');
ylabel(methodType);
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
title('一阶导数MSD');
% legend('show');
xlim([500,3000]);