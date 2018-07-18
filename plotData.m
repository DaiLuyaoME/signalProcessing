figure;
num = numel(data);
numSize = zeros(num,1);
for i = 1 : num
    plot(data{i});
    hold on;
    numSize(i) = numel(data{i});
end
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);
xlim([500,3000]);
% axis tight;
%%
fs = 49;
Ts = 1/fs;
%%
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
[b,a] = secOrderFilter(0.003 / 2 * fs, fs);
%% 滤波
filteredPowerData = cell(num,1);
filteredPowerDataZeroPhaseError = cell(num,1);
for i = 1 : num
    filteredPowerData{i} = filter(dataFilter,data{i});
    filteredPowerDataZeroPhaseError{i} = filtfilt(dataFilter,data{i});
%     filteredPowerData{i} = filter(b,a,data{i});
%     filteredPowerDataZeroPhaseError{i} = filtfilt(b,a,data{i});
end

figure;
for i = 1 : num
    plot(filteredPowerData{i}(1:end),'LineWidth',2);
    hold on;
end
xlabel('采样点');ylabel('滤波后电机功率');set(gca,'FontSize',14);
% axis tight;
xlim([300,3200]);

figure;
for i = 1 : num
    plot(filteredPowerDataZeroPhaseError{i},'LineWidth',2);
    hold on;
end
xlabel('采样点');ylabel('零相位滤波后电机功率');set(gca,'FontSize',14);
% axis tight;
xlim([300,3200]);
% filteredPowerData = filter(dataFilter,powerData);
%% 对信号进行滤波
num = numel(data);
figure;
for i = 1:num
	[pxx,f] = pwelch(data{i});
	plot(f./pi,10*log(pxx),'LineWidth',2);
	hold on;
end
xlabel('Normalized Frequency  (\times\pi rad/sample)');
ylabel('Power/frequency (dB/rad/sample)');
set(gca,'FontSize',14);