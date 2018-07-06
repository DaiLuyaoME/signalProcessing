%% load data
% data = csvread('./data/dataSet1/Raw_6.csv',2,1);
close all;
data = csvread('./data/dataSet2/E8L030#13.csv',2,1);
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
threshold = 300;
powerData = data(:,1);
% powerData = powerData(abs(powerData)>threshold);
powerData = powerData(25:end);
powerDataMeaned = powerData - mean(powerData);

figure;pwelch(powerDataMeaned,1000,500,1000,fs);
[pxx,f] = pwelch(powerDataMeaned,1000,500,1000,fs);
figure;semilogx(f,cumsum(pxx));title('�ۻ�������Welch');

figure;periodogram(powerDataMeaned,[],[],fs);
[pxx,f] = periodogram(powerDataMeaned,[],[],fs);
figure;semilogx(f,cumsum(pxx));title('�ۻ�����������ͼ');

figure;pmtm(powerDataMeaned,[],[],fs);
[pxx,f] = pmtm(powerDataMeaned,[],[],fs);
figure;semilogx(f,cumsum(pxx));title('�ۻ�������Thomson����');

%%
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .01, 'PassbandRipple', 0.01);
filteredPowerData = filter(dataFilter,powerData);
figure;plot([powerData,filteredPowerData]);
%%
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
legend('ԭʼ����','��ͨ�˲�','����λ����ͨ�˲�');set(gca,'FontSize',14);
%%
figure; pwelch(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('�˲������׹���Welch����');
figure; periodogram(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('�˲������׹�������ͼ����');
% figure;[pxx,f] = periodogram(filteredPowerDataZeroPhaseError,[],[],fs);title('�˲������׹�������ͼ����');
%%
figure;
cumPower = cumsum((pxx));
h = semilogx(f,cumPower);
%%
figure;plot(diff(filteredPowerDataZeroPhaseError));
figure;plot(diff(diff(filteredPowerDataZeroPhaseError)));
%%
originalData = filteredPowerDataZeroPhaseError;
firDev = diff(originalData);
secDev = diff(originalData,2);
num = numel(secDev);
figure;scalePlot([originalData(1:num),firDev(1:num),secDev(1:num)]);legend('ԭʼ����','һ�׵���','���׵���');
% figure;
% plot(filteredPowerDataZeroPhaseError);hold on;
% plot(diff(filteredPowerDataZeroPhaseError));
% plot(diff(diff(filteredPowerDataZeroPhaseError)));

%% �˲���Ƶ�׷�����������Ƶ��
dataToFilt = filteredPowerDataZeroPhaseError;
figure;plot(dataToFilt);
dataToFiltMean = dataToFilt - mean(dataToFilt);
figure;plot(dataToFiltMean);
figure;pwelch(dataToFiltMean,1000,500,1000,fs);
[pxx,f] = pwelch(dataToFiltMean,1000,500,1000,fs);
figure;semilogx(f,cumsum(pxx));title('�˲����ۻ�������Welch');

figure;periodogram(dataToFiltMean,[],[],fs);
[pxx,f] = periodogram(dataToFiltMean,[],[],fs);
figure;semilogx(f,cumsum(pxx));title('�˲����ۻ�����������ͼ');

figure;pmtm(dataToFiltMean,[],[],fs);
[pxx,f] = pmtm(dataToFiltMean,[],[],fs);
figure;semilogx(f,cumsum(pxx));title('�˲����ۻ�������Thomson����');


%% �˲���Ƶ�׷�������������Ƶ��
dataToFilt = filteredPowerDataZeroPhaseError;
figure;plot(dataToFilt);
dataToFiltMean = dataToFilt - mean(dataToFilt);
figure;plot(dataToFiltMean);
figure;pwelch(dataToFiltMean);
[pxx,f] = pwelch(dataToFiltMean);
figure;semilogx(f,cumsum(pxx));title('�˲����ۻ�������Welch');

figure;periodogram(dataToFiltMean);
[pxx,f] = periodogram(dataToFiltMean);
figure;semilogx(f,cumsum(pxx));title('�˲����ۻ�����������ͼ');

figure;pmtm(dataToFiltMean);
[pxx,f] = pmtm(dataToFiltMean);
figure;semilogx(f,cumsum(pxx));title('�˲����ۻ�������Thomson����');