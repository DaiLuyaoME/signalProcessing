%% �о���ͬ�˲����Լ�ֵ����뼰���ֵ��Ӱ��
clear disLoc1;
clear disLoc2;
clear valLoc1;
clear valLoc2;
clc;
% minHeight��maxHeightҪ���ݴ��ڴ�С����
minHeight = 1;
maxHeight = 0.2;
windowSize = 30;
clear dataFilter;
dataFilter{1} = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .0023, 'PassbandRipple', 0.01);
dataFilter{2} = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
dataFilter{3} = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .004, 'PassbandRipple', 0.01);
dataFilter{4} = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
%% �������ļ�MSD����ֵ�ͼ�Сֵ������
for k = 1:4
deadtime = 1700;
tempFlag = 2;
num = numel(data);
tempData = cell(size(data));

for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter{k},data{i});
            dataName = '����λ�˲�������';
        case 2
            tempData{i} = filter(dataFilter{k},data{i});
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
            tempData{i} = filtfilt(dataFilter{k},data{i});
            dataName = '����λ�˲�������';
        case 2
            tempData{i} = filter(dataFilter{k},data{i});
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
% figure;plot(distanceVal);
disLoc2{k} = distanceLoc;
valLoc2{k} = distanceVal;

end

%% ���� ��ֵ�����
tempDataPlot = cell2mat(disLoc2);
figure;
h = plot(tempDataPlot,'LineWidth',2);
h(1).DisplayName = '�˲�����ֹƵ��0.0023\pi';
h(2).DisplayName = '�˲�����ֹƵ��0.003\pi';
h(3).DisplayName = '�˲�����ֹƵ��0.004\pi';
h(4).DisplayName = '�˲�����ֹƵ��0.005\pi';
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
tempDataPlot = cell2mat(valLoc2);
figure;
h = plot(tempDataPlot,'LineWidth',2);
h(1).DisplayName = '�˲�����ֹƵ��0.0023\pi';
h(2).DisplayName = '�˲�����ֹƵ��0.003\pi';
h(3).DisplayName = '�˲�����ֹƵ��0.004\pi';
h(4).DisplayName = '�˲�����ֹƵ��0.005\pi';
h(1).Marker = 'diamond';
h(2).Marker = '*';
h(3).Marker = 'o';
h(4).Marker = '+';
xlabel('�����ļ����');
ylabel('MSD���ֵ');
legend('show');
set(gca,'fontsize',14);
axis tight;