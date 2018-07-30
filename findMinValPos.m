%% �������ļ�����ֵ��Сֵ���ע
% Ѱ������2��Сֵ���׼ȷλ��
clc;
% minHeight��maxHeightҪ���ݴ��ڴ�С����
minHeight = 1;
maxHeight = 1000;
windowSize = 30;
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% �������ļ�MSD����ֵ�ͼ�Сֵ������
close all;
deadtime = 1700;
tempFlag = 1;% ��ΪҪ��׼ȷλ�ã����Ҫ��������λ�˲�
dataIndex = 1:75;
num = numel(dataIndex);
tempData = cell(num,1);

for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{dataIndex(i)});
            dataName = '����λ�˲�������';
        case 2
            tempData{i} = filter(dataFilter,data{dataIndex(i)});
            dataName = '�˲�������';
    end
end

for i = 1:num
    [loc,val] = findNotch(tempData{i},maxHeight);
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    locMin(i) = loc(1);  
    valMin(i) = val(1);
end
%% ����
figure;
for i = 1:num
    plot(tempData{i},'LineWidth',2);
    hold on;
end
xlim([deadtime,3000]);
hold on;
plot(locMin,valMin,'o','LineWidth',3);
xlabel('������');
ylabel('MSD');
set(gca,'fontsize',14);