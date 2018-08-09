% wo = 60/(300/2);  bw = wo/35;
% [b1,a1] = iirnotch(wo,wo/35);
% [b2,a2] = iirnotch(wo,wo/180,-20);
% fvtool(b1,a1,b2,a2);
close all;
%% 0.0156�д��ݲ������
wo = 0.0156;  bw = wo/3000;notchDepth = -60;
[b,a] = iirnotch(wo,bw,notchDepth);
fvtool(b,a);
% figure;bodeplot(tf(b,a));

%% ��ȡ���ݣ����źŽ��е�ͨ�˲�
% ��ȡ���ݼ�2��һ�������ļ�
data = csvread('./data/dataSet2/E8L030#13.csv',2,1);
powerData = data(:,1);  % ��������ź�
% ������˲�����ֹƵ��ѡ0.01�У�����0.0156�еĹ����Ͳ��ᱻ�������
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .01, 'PassbandRipple', 0.01);
% ʵʱ�˲�
filteredPowerData = filter(dataFilter,powerData); 
% ����λ�˲�
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);

%% ԭʼ�ź��ݲ�ǰ��ʱ�򼰹����׶Ա�
dataToFilt = filteredPowerDataZeroPhaseError;
% dataToFilt = filteredPowerData;
dataToFilt = powerData;
tempData1 = filtfilt(b,a,dataToFilt);
tempData2 = filter(b,a,dataToFilt);
% �ݲ�ǰ��ʱ������
figure;
plot([dataToFilt,tempData1,tempData2],'LineWidth',2);
h = legend('ԭʼ����','����λ����ݲ�','�ݲ�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;

% �ݲ�ǰ�����׶Ա�
figure;pwelch([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1),tempData2 - mean(tempData2)]);
h = legend('ԭʼ����','����λ����ݲ�','�ݲ�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
%% ʵʱ�˲����ź��ݲ�ǰ��ʱ�򼰹����׶Ա�
% dataToFilt = filteredPowerDataZeroPhaseError;
dataToFilt = filteredPowerData;
% dataToFilt = powerData;
tempData1 = filtfilt(b,a,dataToFilt);
tempData2 = filter(b,a,dataToFilt);
% �ݲ�ǰ��ʱ������
figure;
plot([dataToFilt,tempData1,tempData2],'LineWidth',2);
h = legend('ʵʱ�˲�������','����λ����ݲ�','�ݲ�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;

% �ݲ�ǰ�����׶Ա�
figure;pwelch([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1),tempData2 - mean(tempData2)]);
h = legend('ʵʱ�˲�������','����λ����ݲ�','�ݲ�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
%% ����λ�˲����ź��ݲ�ǰ��ʱ�򼰹����׶Ա�
dataToFilt = filteredPowerDataZeroPhaseError;
% dataToFilt = filteredPowerData;
% dataToFilt = powerData;
tempData1 = filtfilt(b,a,dataToFilt);
tempData2 = filter(b,a,dataToFilt);
% �ݲ�ǰ��ʱ������
figure;
plot([dataToFilt,tempData1,tempData2],'LineWidth',2);
h = legend('����λ�˲�������','����λ����ݲ�','�ݲ�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;

% �ݲ�ǰ�����׶Ա�
figure;pwelch([dataToFilt - mean(dataToFilt),tempData1 - mean(tempData1),tempData2 - mean(tempData2)]);
h = legend('����λ�˲�������','����λ����ݲ�','�ݲ�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;