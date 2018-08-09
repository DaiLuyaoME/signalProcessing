%%
close all;
clear;
%% ���뵥�������ļ�

% �������ݼ�1�������ļ�
% singleData = csvread('./data/dataSet1/Raw_3.csv',2,1);
% powerData = singleData(:,2);
% pos1 = singleData(:,3);
% pos2 = singleData(:,4);

% �������ݼ�2�������ļ�
singleData = csvread('./data/dataSet2/E8L030#13.csv',2,1);
powerData = singleData(:,1);
pos1 = singleData(:,2);
pos2 = singleData(:,3);

fs = 39;
Ts = 1/fs;

numCol = size(singleData,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(singleData(:,i));
end

figure;plot(powerData);
%% �˲������
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% ���źŽ����˲�
powerData = powerData(1:end);
filteredPowerData = filter(dataFilter,powerData);
% filteredPowerData = filter(b6,1,powerData);
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
% filteredPowerDataZeroPhaseError = filtfilt(b6,1,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('ԭʼ����','��ͨ�˲�','����λ����ͨ�˲�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
%% ��������������
% close all;
% tempFlag = 1, ��������λ�˲��󣬵������������ tempFlag = 2�� ����ʵʱ�˲��󣬵������������
tempFlag = 2;
switch tempFlag
    case 1
        tempData = filteredPowerDataZeroPhaseError;
        dataName = '����λ�˲�������';
    case 2
        tempData = filteredPowerData;
        dataName = '�˲�������';
end

% ������ʼ��λ��
startPoint = 300;
% �����õĴ��ڴ�С
windowSize = 30;
% �������������MSD��ʱ������MSD����MA��ʱ����MA
methodType = 'MSD';
% ��������
result = calCharacter(tempData,windowSize,startPoint,methodType);

% ��������MSD
figure;
plot(result,'DisplayName','MSD','LineWidth',2);
xlim([500,numel(tempData)]);

% ����MSD�����ԭʼ���ʡ��˲�����
figure;
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(tempData,'DisplayName',dataName,'LineWidth',2,'Color','black'); ylabel('�������');
yyaxis right;
plot(result,'DisplayName',methodType,'LineWidth',2);
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0�̶���');
ylabel(methodType);
xlabel('������');set(gca,'FontSize',14);
axis tight;
legend('show');
xlim([500,numel(tempData)]);
%% �����������ź�һ�׵�������
% close all;
% tempFlag = 1, ��������λ�˲��󣬵������������ tempFlag = 2�� ����ʵʱ�˲��󣬵������������
tempFlag = 2;
switch tempFlag
    case 1
        tempData = diff(filteredPowerDataZeroPhaseError);
        tempFilterData = filteredPowerDataZeroPhaseError;
        dataName = 'һ�׵���������λ�˲���';
        tempFilterDataName = '���ź�����λ�˲�������';
    case 2
        tempData = diff(filteredPowerData);
        tempFilterData = filteredPowerData;
        dataName = 'һ�׵���';
        tempFilterDataName = '���ź��˲�������';
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 30;
methodType = 'MSD';

result = calCharacter(tempData,windowSize,startPoint,methodType);
% figure;plot([powerData,result]);

figure;
yyaxis left;
% tempRatio = max(abs(tempData)) / max(abs(tempFilterData)) ;
% plot(tempRatio*powerData,'DisplayName','���ź�ԭʼ����');
% hold on ;
% plot(tempRatio*tempFilterData,'DisplayName',tempFilterDataName,'LineWidth',2,'Color','black'); ylabel('�������һ�׵���');
plot(tempData,'DisplayName',dataName,'LineWidth',2);
hold on;
plot(zeros(size(tempData)),'DisplayName','0�̶���','LineWidth',4,'Color','black');
ylabel('�������һ�׵���');
yyaxis right;
plot(result,'DisplayName',methodType,'LineWidth',2);
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0�̶���');
ylabel(methodType);
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'northwest';
xlim([500,numel(tempData)]);
%% �����������źŶ��׵�������
% close all;
% tempFlag = 1, ��������λ�˲��󣬵������������ tempFlag = 2�� ����ʵʱ�˲��󣬵������������
tempFlag = 1;
switch tempFlag
    case 1
        tempData = diff(filteredPowerDataZeroPhaseError,2);
        tempFilterData = filteredPowerDataZeroPhaseError;
        dataName = '���׵���������λ�˲���';
        tempFilterDataName = '���ź�����λ�˲�������';
    case 2
        tempData = diff(filteredPowerData,2);
        tempFilterData = filteredPowerData;
        dataName = '���׵���';
        tempFilterDataName = '���ź��˲�������';
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 30;
methodType = 'MSD';

result = calCharacter(tempData,windowSize,startPoint,methodType);
% figure;plot([powerData,result]);

figure;
yyaxis left;
% tempRatio = max(abs(tempData)) / max(abs(tempFilterData)) ;
% plot(tempRatio*powerData,'DisplayName','���ź�ԭʼ����');
% hold on ;
% plot(tempRatio*tempFilterData,'DisplayName',tempFilterDataName,'LineWidth',2,'Color','black'); ylabel('�������һ�׵���');
plot(tempData,'DisplayName',dataName,'LineWidth',2);
hold on;
plot(zeros(size(tempData)),'DisplayName','0�̶���','LineWidth',4,'Color','black');
ylabel('������ʶ��׵���');
yyaxis right;
plot(result,'DisplayName',methodType,'LineWidth',2);
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0�̶���');
ylabel(methodType);
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'northwest';
xlim([500,numel(tempData)]);
%% ���㲻ͬ���ڴ�С�£�ͬһ�����ļ�������������仯���
% close all;
% tempFlag = 1, ��������λ�˲��󣬵������������ tempFlag = 2�� ����ʵʱ�˲��󣬵������������
tempFlag = 2;
switch tempFlag
    case 1
        tempData = filteredPowerDataZeroPhaseError;
        dataName = '����λ�˲�������';
    case 2
        tempData = filteredPowerData;
        dataName = 'ʵʱ�˲�������';
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = floor(linspace(5,300,10));
num = numel(windowSize);
methodType = 'MSD';
result = zeros(numel(tempData),num);
nameCell = cell(num,1);
for i = 1:num
    tempSize = windowSize(i);
    result(:,i) = calCharacter(tempData,tempSize,startPoint,methodType);
    nameCell{i} = sprintf('%d',tempSize);
    % figure;plot([powerData,result]);
end
figure;
plot(result,'LineWidth',2);
% grid on;
% hold on;plot(zeros(size(secDev)),'DisplayName','0�̶���');
ylabel([dataName,methodType]);
xlabel('������');set(gca,'FontSize',14);
axis tight;
legend(nameCell);
xlim([1700,numel(tempData)]);
