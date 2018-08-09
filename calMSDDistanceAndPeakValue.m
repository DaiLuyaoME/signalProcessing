%% MSD����ֵ�ͼ�Сֵ����ͷ��ֵ����

%% �����ر���
clear disLoc1; % disLoc1�洢ʵʱ�˲�ʱ��MSD����ֵ��Сֵ����
clear disLoc2; % disLoc2�洢����λ�˲�ʱ��MSD����ֵ��Сֵ����
clear disVal1; % disVal1�洢ʵʱ�˲�ʱ��MSD���ֵ
clear disVal2; % disVal2�洢����λ�˲�ʱ��MSD���ֵ
clc;
%% �������ݼ���ȫ�������ļ�
loadData;
%% �趨��ֵ
% minHeight��maxHeightҪ���ݴ��ڴ�С����
minHeight = 0.8; % ����ֵ��ֵ
maxHeight = 0.3; % ��Сֵ��ֵ
windowSize = 30;
%% ����˲���
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% �������ļ�MSD����ֵ�ͼ�Сֵ�������
close all;
deadtime = 1700;
tempFlag = 2; % ����ʵʱ�˲�
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
    val = val(loc>loc1);  % ���ҵ���һ��MSD����ֵ��󣬲������⼫Сֵ��
    loc = loc(loc>loc1);
    loc2 = loc(1);  
    val2 = val(1);
    distanceLoc(i) = loc2 - loc1; % ����ֵ�ͼ�Сֵ����
    distanceVal(i) = val1 - val2; % ����ֵ�ͼ�Сֵ֮������ֵ
end
% figure;
% plot(distanceLoc);
figure;plot(distanceVal);
disLoc1 = distanceLoc;
disVal1 = distanceVal;
%% �������ļ�MSD����ֵ�ͼ�Сֵ������
close all;
deadtime = 1700;
tempFlag = 1; % ��������λ�˲�
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

