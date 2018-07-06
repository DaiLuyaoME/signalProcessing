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
figure;semilogx(f,cumsum(pxx));title('累积功率谱Welch');

figure;periodogram(powerDataMeaned,[],[],fs);
[pxx,f] = periodogram(powerDataMeaned,[],[],fs);
figure;semilogx(f,cumsum(pxx));title('累积功率谱周期图');

figure;pmtm(powerDataMeaned,[],[],fs);
[pxx,f] = pmtm(powerDataMeaned,[],[],fs);
figure;semilogx(f,cumsum(pxx));title('累积功率谱Thomson方法');

%%
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .01, 'PassbandRipple', 0.01);
filteredPowerData = filter(dataFilter,powerData);
figure;plot([powerData,filteredPowerData]);
%%
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
legend('原始数据','低通滤波','零相位误差低通滤波');set(gca,'FontSize',14);
%%
figure; pwelch(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('滤波后功率谱估计Welch方法');
figure; periodogram(filteredPowerDataZeroPhaseError - mean(filteredPowerDataZeroPhaseError));title('滤波后功率谱估计周期图方法');
% figure;[pxx,f] = periodogram(filteredPowerDataZeroPhaseError,[],[],fs);title('滤波后功率谱估计周期图方法');
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
figure;scalePlot([originalData(1:num),firDev(1:num),secDev(1:num)]);legend('原始数据','一阶导数','二阶导数');
% figure;
% plot(filteredPowerDataZeroPhaseError);hold on;
% plot(diff(filteredPowerDataZeroPhaseError));
% plot(diff(diff(filteredPowerDataZeroPhaseError)));

%% 滤波后频谱分析，带采样频率
dataToFilt = filteredPowerDataZeroPhaseError;
figure;plot(dataToFilt);
dataToFiltMean = dataToFilt - mean(dataToFilt);
figure;plot(dataToFiltMean);
figure;pwelch(dataToFiltMean,1000,500,1000,fs);
[pxx,f] = pwelch(dataToFiltMean,1000,500,1000,fs);
figure;semilogx(f,cumsum(pxx));title('滤波后累积功率谱Welch');

figure;periodogram(dataToFiltMean,[],[],fs);
[pxx,f] = periodogram(dataToFiltMean,[],[],fs);
figure;semilogx(f,cumsum(pxx));title('滤波后累积功率谱周期图');

figure;pmtm(dataToFiltMean,[],[],fs);
[pxx,f] = pmtm(dataToFiltMean,[],[],fs);
figure;semilogx(f,cumsum(pxx));title('滤波后累积功率谱Thomson方法');


%% 滤波后频谱分析，不含采样频率
dataToFilt = filteredPowerDataZeroPhaseError;
figure;plot(dataToFilt);
dataToFiltMean = dataToFilt - mean(dataToFilt);
figure;plot(dataToFiltMean);
figure;pwelch(dataToFiltMean);
[pxx,f] = pwelch(dataToFiltMean);
figure;semilogx(f,cumsum(pxx));title('滤波后累积功率谱Welch');

figure;periodogram(dataToFiltMean);
[pxx,f] = periodogram(dataToFiltMean);
figure;semilogx(f,cumsum(pxx));title('滤波后累积功率谱周期图');

figure;pmtm(dataToFiltMean);
[pxx,f] = pmtm(dataToFiltMean);
figure;semilogx(f,cumsum(pxx));title('滤波后累积功率谱Thomson方法');