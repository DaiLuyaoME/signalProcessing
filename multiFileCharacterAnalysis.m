%% �������ݼ���ȫ�������ļ�
loadData;
%% �������ļ����������������
% tempFlag = 1, ��������λ�˲��󣬵������������ tempFlag = 2�� ����ʵʱ�˲��󣬵������������
tempFlag = 2;
num = numel(data);
tempData = cell(size(data));
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{i});
            dataName = '����λ�˲���';
        case 2
            tempData{i} = filter(dataFilter,data{i});
            dataName = 'ʵʱ�˲���';
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
title([dataName,'�������MSD']);
ylabel(methodType);
xlabel('������');set(gca,'FontSize',14);
axis tight;
% legend('show');
xlim([500,3000]);
%% �������ļ��������һ�׵�����������
% tempFlag = 1, ��������λ�˲��󣬵������������ tempFlag = 2�� ����ʵʱ�˲��󣬵������������
tempFlag = 2;
num = numel(data);
tempData = cell(size(data));
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = diff(filtfilt(dataFilter,data{i}));
            dataName = 'һ�׵���������λ�˲���';
        case 2
            tempData{i} = diff(filter(dataFilter,data{i}));
            dataName = 'һ�׵���';
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
plot(zeros(1,3000),'DisplayName','0�̶���','LineWidth',2,'Color','black');
ylabel(methodType);
xlabel('������');set(gca,'FontSize',14);
axis tight;
title('һ�׵���MSD');
% legend('show');
xlim([500,3000]);