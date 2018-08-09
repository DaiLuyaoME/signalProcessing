%% 载入数据集中全部数据文件
loadData;
%% 多数据文件原始功率信号绘制
figure;
num = numel(data);
numSize = zeros(num,1);
for i = 1 : num
    plot(data{i});
    hold on;
    numSize(i) = numel(data{i});
    dataPre{i} = dataPreProcess(data{i},pos1{i},pos2{i},17);
end
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);
% 设定x轴的绘制范围
xlim([500,3000]);
% axis tight;
%% 设计滤波器
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% 多数据文件实时滤波和零相位滤波结果分析
filteredPowerData = cell(num,1);
filteredPowerDataZeroPhaseError = cell(num,1);
for i = 1 : num
    filteredPowerData{i} = filter(dataFilter,data{i});
    filteredPowerDataZeroPhaseError{i} = filtfilt(dataFilter,data{i});
end

figure;
for i = 1 : num
    plot(filteredPowerData{i}(1:end),'LineWidth',2);
    hold on;
end
xlabel('采样点');ylabel('实时滤波后电机功率');set(gca,'FontSize',14);
% axis tight;
% 设定x轴的绘制范围
xlim([1000,3000]);

figure;
for i = 1 : num
    plot(filteredPowerDataZeroPhaseError{i},'LineWidth',2);
    hold on;
end
xlabel('采样点');ylabel('零相位滤波后电机功率');set(gca,'FontSize',14);
% axis tight;
% 设定x轴的绘制范围
xlim([1000,3000]);
% filteredPowerData = filter(dataFilter,powerData);
%% 多数据文件功率谱分析
num = numel(data);
figure;
for i = 1:num
	[pxx,f] = pwelch(data{i}-mean(data{i}));
	plot(f./pi,10*log(pxx),'LineWidth',2);
	hold on;
%     	[pxx,f] = pwelch(dataPre{i});
% 	plot(f./pi,10*log(pxx),'--','LineWidth',2);
end
xlabel('Normalized Frequency  (\times\pi rad/sample)');
ylabel('Power/frequency (dB/rad/sample)');
set(gca,'FontSize',14);