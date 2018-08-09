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

numCol = size(singleData,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(singleData(:,i));
end

figure;plot(powerData);
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
powerData = powerData(1:end);
filteredPowerData = filter(dataFilter,powerData);
% filteredPowerData = filter(b6,1,powerData);
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
% filteredPowerDataZeroPhaseError = filtfilt(b6,1,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('ԭʼ����','��ͨ�˲�','����λ����ͨ�˲�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
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
startPoint = 300;
windowSize = 30;
methodType = 'MSD';
result = calCharacter(tempData,windowSize,startPoint,methodType);

%% ��������MSD ����һ�׵�������
% ��Ҫ������tempTest���õ��������ݵ�MSD
deadtime = 1700;
tempResult = result;
figure;
yyaxis left;
plot(tempResult,'LineWidth',2,'DisplayName','������MSD');
xlabel('������');
ylabel('MSD');
hold on;
yyaxis right;
plot(diff(tempResult),'LineWidth',2,'displayname','MSDһ�׵���');
hold on; plot(zeros(size(tempResult)),'LineWidth',2,'displayName','0�̶���','LineStyle','--','color','black');
ylabel('MSDһ�׵���');
legend show;
xlim([deadtime,numel(tempResult)]);
set(gca,'fontsize',14);
% figure;findpeaks(tempResult);
%% ��������MSD��Сֵ��ץȡ
deadtime = 1700;
[loc,val] = findNotch(result,0.1);
val = val(loc>deadtime);
loc = loc(loc>deadtime);
figure;
plot(result,'DisplayName','MSD','LineWidth',4);
hold on;
plot(loc,val,'o','linewidth',4);
xlim([deadtime,numel(result)]);
xlabel('������');
ylabel('MSD');
set(gca,'Fontsize',14);
%% ��������MSD����ֵץȡ
deadtime = 1700;
[loc,val] = findPeak(result,1);
val = val(loc>deadtime);
loc = loc(loc>deadtime);
figure;
plot(result,'DisplayName','MSD','LineWidth',4);
hold on;
plot(loc,val,'diamond','linewidth',4);
xlim([deadtime,numel(result)]);
xlabel('������');
ylabel('MSD');
set(gca,'Fontsize',14);
% %
% �������ļ�MSD����ֵ�ͼ�Сֵ������

%%  �������ݼ�ȫ���ļ�
calMSDDistanceAndPeakValue;
%% �������ļ�ʵʱ�˲�������λ�˲���ֵ�����Ա�
% �ýڴ�����Ҫ������calMSDDistanceAndPeakValue.m�ű���
figure;
h = plot([disLoc1,disLoc2],'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('ʵʱ�˲�','����λ�˲�');
set(gca,'fontsize',14);
xlabel('�����ļ����');
ylabel('��ֵ�����  (��λ�����������)');
axis('tight');
figure;
h = errorbar([disLoc1,disLoc2], [disLoc1,disLoc2] - mean([disLoc1,disLoc2]),'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('ʵʱ�˲�','����λ�˲�');
set(gca,'fontsize',14);
xlabel('�����ļ����');
ylabel('��ֵ�����ƫ��  (��λ�����������)');
axis('tight');
%% �������ļ�ʵʱ�˲�������λ�˲���ֵ����ֵ
% �ýڴ�����Ҫ������calMSDDistanceAndPeakValue.m�ű���
figure;
h = plot([disVal1,disVal2],'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('ʵʱ�˲�','����λ�˲�');
set(gca,'fontsize',14);
xlabel('�����ļ����');
ylabel('MSD���ֵ');
axis('tight');
figure;
h = errorbar([disVal1,disVal2], [disVal1,disVal2] - mean([disVal1,disVal2]),'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('ʵʱ�˲�','����λ�˲�');
set(gca,'fontsize',14);
xlabel('�����ļ����');
ylabel('MSD���ֵƫ��');
axis('tight');
