%% �ر����л�ͼ��������б���
close all;
clear;
%% ��ȡ����
% ע�⣬���ݼ�1�����ݼ�2����������˳����������˵�9�д���͵�13�д�������˲�ͬ����������

% ��ȡ���ݼ�1��һ�������ļ�
% data = csvread('./data/dataSet1/Raw_5.csv',2,1);
% powerData = data(:,2); %��������ź�

% ��ȡ���ݼ�2��һ�������ļ�
data = csvread('./data/dataSet2/E8L030#13.csv',2,1);
powerData = data(:,1);  % ��������ź�

%% �������Ƶ�����������
fs = 39;
Ts = 1/fs;
%% ���Ƶ�����ʡ�����λ�úͰڶ��Ƕ�
numCol = size(data,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(data(:,i));
end
%% �������Ƶ�������ź�
figure;plot(powerData,'LineWidth',1,'DisplayName','ԭʼ����');xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
%% ����ԭʼ��������ź�Ƶ��
tempData = powerData(1:end);
% ����������֮ǰ��Ҫ�ȼ�ȥƽ��ֵ���ų�ֱ��������Ӱ��
powerDataMeaned = tempData - mean(tempData);
% type = 1, ��һ�������ף���Ƶ��Ϊ��һ��Ƶ�ʣ��� type = 2�� ��ʵƵ�ʹ�����
type = 1;
switch type
    case 1
        % Welch����
        figure;  pwelch(powerDataMeaned);
        [pxx,f] = pwelch(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�������Welch');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        % ����ͼ��
        figure;periodogram(powerDataMeaned);
        [pxx,f] = periodogram(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�����������ͼ');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        % Tomson����
        figure;pmtm(powerDataMeaned);
        [pxx,f] = pmtm(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�������Thomson����');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
    case 2
        
        
        figure;pwelch(powerDataMeaned,1000,500,1000,fs);
        [pxx,f] = pwelch(powerDataMeaned,1000,500,1000,fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('�ۻ�������Welch');
        
        figure;periodogram(powerDataMeaned,[],[],fs);
        [pxx,f] = periodogram(powerDataMeaned,[],[],fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('�ۻ�����������ͼ');
        
        figure;pmtm(powerDataMeaned,[],[],fs);
        [pxx,f] = pmtm(powerDataMeaned,[],[],fs);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('�ۻ�������Thomson����');
        
end

%% ����˲���
% ��ο�MATLAB�Դ������ĵ��˽�designfilt������ʹ��˵��
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% �Ե�������źŽ����˲�
% ʵʱ�˲�
filteredPowerData = filter(dataFilter,powerData); 
% ����λ�˲�
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
% filteredPowerDataZeroPhaseError = filtfilt(b6,1,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('ԭʼ����','��ͨ�˲�','����λ����ͨ�˲�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
%% �˲����������ۻ�������
figure; pwelch(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('����λ�˲������׹���Welch����')
figure; pwelch(filteredPowerData - mean(filteredPowerData));title('�˲������׹���Welch����');
[pxx,f] = pwelch(filteredPowerData-mean(filteredPowerData));
figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('�ۻ�������Welch');
%% ����ʵʱ�˲�������λ�˲����һ�׵����Ͷ��׵���
originalData = filteredPowerData;
firDev = diff(originalData);
secDev = diff(originalData,2);
originalDataZeroPhase = filteredPowerDataZeroPhaseError;
firDevZeroPhase = diff(originalDataZeroPhase);
secDevZeroPhase = diff(originalDataZeroPhase,2);
num = numel(secDevZeroPhase);
%% ����һ�׵���
% ����λ�˲�һ�׵�������
figure;
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(originalDataZeroPhase,'DisplayName','����λ����˲�������','LineWidth',2,'Color','r'); ylabel('�������');
yyaxis right;
plot(firDevZeroPhase,'DisplayName','һ�׵���','LineWidth',2);grid on;hold on;plot(zeros(size(firDevZeroPhase)),'DisplayName','0�̶���','LineWidth',4,'Color','black');
ylabel('һ�׵���');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'northwest';
xlim([500,numel(powerData)]);
% ʵʱ�˲�һ�׵�������
figure;
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(originalData,'DisplayName','�˲�������','LineWidth',2,'Color','r'); ylabel('�������');
yyaxis right;
plot(firDev,'DisplayName','һ�׵���','LineWidth',2);grid on;hold on;plot(zeros(size(firDev)),'DisplayName','0�̶���','LineWidth',4,'Color','black');
ylabel('һ�׵���');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'northwest';
xlim([500,numel(powerData)]);

%% ���ƶ��׵���
% ����λ�˲����׵�������
figure;
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(originalDataZeroPhase,'DisplayName','����λ����˲�������','LineWidth',2,'Color','r'); ylabel('�������');
yyaxis right;
plot(secDevZeroPhase,'DisplayName','���׵���','LineWidth',2);grid on;hold on;plot(zeros(size(secDevZeroPhase)),'DisplayName','0�̶���');
ylabel('���׵���');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';
xlim([1000,numel(powerData)]);
% ʵʱ�˲����׵�������
figure;
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(originalDataZeroPhase,'DisplayName','�˲�������','LineWidth',2,'Color','r'); ylabel('�������');
yyaxis right;
plot(secDev,'DisplayName','���׵���','LineWidth',2);grid on;hold on;plot(zeros(size(secDev)),'DisplayName','0�̶���');
ylabel('���׵���');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';
xlim([1000,numel(powerData)]);

