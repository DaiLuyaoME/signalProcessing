%%
close all;
clear;
%% load data
% data = csvread('./data/dataSet1/Raw_5.csv',2,1);
data = csvread('./data/dataSet2/E8L029#04.csv',2,1);
%%
fs = 49;
Ts = 1/fs;
%%
numCol = size(data,2);
figure;
for i = 1:numCol
    subplot(2,2,i);
    plot(data(:,i));
end
%%
% powerData = data(:,2);
powerData = data(:,1);
figure;plot(powerData,'LineWidth',1,'DisplayName','ԭʼ����');xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
% powerData = powerData(abs(powerData)>threshold);
threshold = 1;
powerData = powerData(threshold:end);

%%
tempData = powerData(1:end);
powerDataMeaned = tempData - mean(tempData);

type = 1; % 1 for normalized; 2 for authenticate;
switch type
    case 1
        figure;  pwelch(powerDataMeaned);
%         plot(f,10*log10(pxx),'LineWidth',2);
%         xlabel('Normalized Frequency  (\times\pi rad/sample)');
%         ylabel('Power/frequency (dB/rad/sample)');
        [pxx,f] = pwelch(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�������Welch');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure;periodogram(powerDataMeaned);
        [pxx,f] = periodogram(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�����������ͼ');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure;pmtm(powerDataMeaned);
        [pxx,f] = pmtm(powerDataMeaned);
        figure;semilogx(f./pi,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�������Thomson����');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure; pmusic(powerDataMeaned,14);
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

%%
powerData = powerData(1:end);
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
% dataFilter = designfilt('lowpassfir', 'FilterOrder', 17, 'PassbandFrequency', .05, 'StopbandFrequency', 0.06);
filteredPowerData = filter(dataFilter,powerData);
figure;plot([powerData,filteredPowerData]);
%%
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',4);
h = legend('ԭʼ����','��ͨ�˲�','����λ����ͨ�˲�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
% [tempx,tempy] = ginput(2);
%%
figure; pwelch(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('����λ�˲������׹���Welch����')
figure; pwelch(filteredPowerData - mean(filteredPowerData));title('�˲������׹���Welch����');
% figure; periodogram(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('�˲������׹�������ͼ����');
% figure;[pxx,f] = periodogram(filteredPowerDataZeroPhaseError,[],[],fs);title('�˲������׹�������ͼ����');
%%
figure;plot(diff(filteredPowerDataZeroPhaseError));
figure;plot(diff(diff(filteredPowerDataZeroPhaseError)));
%%
% originalData = filteredPowerData;
originalData = filteredPowerData;
firDev = diff(originalData);
secDev = diff(originalData,2);
originalDataZeroPhase = filteredPowerDataZeroPhaseError;
firDevZeroPhase = diff(originalDataZeroPhase);
secDevZeroPhase = diff(originalDataZeroPhase,2);
num = numel(secDevZeroPhase);
%% һ�׵�������
figure; 
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(originalDataZeroPhase,'DisplayName','����λ����˲�������','LineWidth',2,'Color','r'); ylabel('�������');
yyaxis right;
plot(firDevZeroPhase,'DisplayName','һ�׵���','LineWidth',2);grid on;hold on;plot(zeros(size(firDevZeroPhase)),'DisplayName','0�̶���');
ylabel('һ�׵���');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

figure; 
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(originalData,'DisplayName','�˲�������','LineWidth',2,'Color','r'); ylabel('�������');
yyaxis right;
plot(firDev,'DisplayName','һ�׵���','LineWidth',2);grid on;hold on;plot(zeros(size(firDev)),'DisplayName','0�̶���');
ylabel('һ�׵���');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

%% ���׵�������
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

%% �˲���Ƶ�׷�����������Ƶ��

tempData = filteredPowerDataZeroPhaseError(40:end);
% tempData = filteredPowerData(1:end);
figure;plot(tempData);
powerDataMeaned = tempData - mean(tempData);

type = 1; % 1 for normalized; 2 for authenticate;
switch type
    case 1
        figure;  pwelch(powerDataMeaned);
%         plot(f,10*log10(pxx),'LineWidth',2);
%         xlabel('Normalized Frequency  (\times\pi rad/sample)');
%         ylabel('Power/frequency (dB/rad/sample)');
        [pxx,f] = pwelch(powerDataMeaned);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�������Welch');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure;periodogram(powerDataMeaned);
        [pxx,f] = periodogram(powerDataMeaned);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�����������ͼ');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');
        
        figure;pmtm(powerDataMeaned);
        [pxx,f] = pmtm(powerDataMeaned);
        figure;semilogx(f,cumsum(pxx) ./ sum(pxx));title('��һ���ۻ�������Thomson����');
        xlabel('Normalized Frequency  (\times\pi rad/sample)');
        ylabel('Power/frequency (%)');        
        figure; pmusic(powerDataMeaned,14);
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
