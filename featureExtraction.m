%% 通过设定deadtime提取MSD特征
close all;
deadtime = 1700;
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
xlim([deadtime,3000]);
%% 实时滤波，MSD最小值点，数据集2
tempIndex = zeros(num,1);
for i = 1:num
    temp = result{i};
    temp = temp(2100:min(2600,numel(temp)));
    [~,tempIndex(i)] = min(temp);
end
tempIndex = tempIndex + 2100 -1;
%% 单组数据MSD 及其一阶导数分析
% 需要先运行tempTest，得到单组数据的MSD
deadtime = 1700;
tempResult = result;
figure;
yyaxis left;
plot(tempResult,'LineWidth',2,'DisplayName','截取后数据');
xlabel('采样点');
ylabel('MSD');
hold on;
yyaxis right;
plot(diff(tempResult),'LineWidth',2,'displayname','一阶导数');
hold on; plot(zeros(size(tempResult)),'LineWidth',2,'displayName','0刻度线','LineStyle','--','color','black');
ylabel('MSD一阶导数');
legend show;
xlim([deadtime,numel(tempResult)]);
set(gca,'fontsize',14);
figure;findpeaks(tempResult);
%% 单组数据MSD极小值分析
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
%% 单组数据MSD极大值分析
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
%% 多数据文件MSD极大值和极小值间距分析
close all;
deadtime = 1700;
tempFlag = 1;
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
windowSize = 60;
methodType = 'MSD';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize,startPoint,methodType);
end

distanceLoc  = zeros(numel(result),1);
distanceVal = zeros(numel(result),1);

for i = 1:num
    [loc,val] = findPeak(result{i},1);
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    loc1 = loc(1);
    val1 = val(1);
     [loc,val] = findNotch(result{i},1);
    val = val(loc>loc1);
    loc = loc(loc>loc1);
    loc2 = loc(1);  
    val2 = val(1);
    distanceLoc(i) = loc2 - loc1;
    distanceVal(i) = val1 - val2;
end
figure;
plot(distanceLoc);
figure;plot(distanceVal);
%% 多数据文件实时滤波和零相位滤波极值点距离对比
% 先运行untitile2
% 要先将实时滤波数据存在disLoc1和disVal1中，零相位滤波数据存在disLoc2和disVal2中
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
%% 多数据文件实时滤波和零相位滤波极值点距离对比
% 要先将实时滤波数据存在disLoc1和disVal1中，零相位滤波数据存在disLoc2和disVal2中
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
ylabel('MSD峰峰值');
axis('tight');

