%% �о���ͬ���ڴ�С�Լ�ֵ����뼰���ֵ��Ӱ��
clear disLoc1;
clear disLoc2;
clear valLoc1;
clear valLoc2;
clc;
% minHeight��maxHeightҪ���ݴ��ڴ�С����
clear windowSize;
windowSize{1} = 30;
windowSize{2} = 60;
windowSize{3} = 90;
windowSize{4} = 120;
clear minHeight;
clear maxHeight;
minHeight = {1,1.5,2,3};
maxHeight = {0.2,1,2,3};
clear dataFilter;
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .0023, 'PassbandRipple', 0.01);

%% �������ļ�MSD����ֵ�ͼ�Сֵ������
for k = 1:4
deadtime = 1700;
tempFlag = 2;
num = numel(data);
tempData = cell(size(data));

for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{i});
            dataName = '����λ�˲�������';
        case 2
            tempData{i} = filter(dataFilter,data{i});
            dataName = '�˲�������';
    end
end
% tempData = diff(filteredPowerData);
startPoint = 300;

methodType = 'MSD';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize{k},startPoint,methodType);
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
end
% figure;
% plot(distanceLoc);
% figure;plot(distanceVal);
disLoc1{k} = distanceLoc;
valLoc1{k} = distanceVal;
%% �������ļ�MSD����ֵ�ͼ�Сֵ������
deadtime = 1700;
tempFlag = 1;
num = numel(data);
tempData = cell(size(data));
for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{i});
            dataName = '����λ�˲�������';
        case 2
            tempData{i} = filter(dataFilter,data{i});
            dataName = '�˲�������';
    end
end
% tempData = diff(filteredPowerData);
startPoint = 300;
% windowSize = 30;
methodType = 'MSD';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize{k},startPoint,methodType);
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
end
% figure;
% plot(distanceLoc);
% figure;plot(distanceVal);
disLoc2{k} = distanceLoc;
valLoc2{k} = distanceVal;

end

%% ���� ��ֵ�����
tempDataPlot = cell2mat(disLoc1);
figure;
h = plot(tempDataPlot,'LineWidth',2);
h(1).DisplayName = '���ڴ�С30';
h(2).DisplayName = '���ڴ�С60';
h(3).DisplayName = '���ڴ�С90';
h(4).DisplayName = '���ڴ�С120';
h(1).Marker = 'diamond';
h(2).Marker = '*';
h(3).Marker = 'o';
h(4).Marker = '+';
xlabel('�����ļ����');
ylabel('��ֵ�����');
legend('show');
set(gca,'fontsize',14);
axis tight;
%% ����
tempDataPlot = cell2mat(valLoc1);
figure;
h = plot(tempDataPlot,'LineWidth',1);
h(1).DisplayName = '���ڴ�С30';
h(2).DisplayName = '���ڴ�С60';
h(3).DisplayName = '���ڴ�С90';
h(4).DisplayName = '���ڴ�С120';
h(1).Marker = 'diamond';
h(2).Marker = '*';
h(3).Marker = 'o';
h(4).Marker = '+';
xlabel('�����ļ����');
ylabel('MSD���ֵ');
legend('show');
set(gca,'fontsize',14);
axis tight;