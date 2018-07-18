figure;
num = numel(data);
numSize = zeros(num,1);
for i = 1 : num
    plot(data{i});
    hold on;
    numSize(i) = numel(data{i});
end
xlabel('采样点');ylabel('电机功率');set(gca,'FontSize',14);
axis tight;
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
    plot(filteredPowerData{i},'LineWidth',2);
    hold on;
end
xlabel('采样点');ylabel('滤波后电机功率');set(gca,'FontSize',14);
axis tight;


figure;
for i = 1 : num
    plot(filteredPowerDataZeroPhaseError{i},'LineWidth',2);
    hold on;
end
xlabel('采样点');ylabel('零相位滤波后电机功率');set(gca,'FontSize',14);
axis tight;

% filteredPowerData = filter(dataFilter,powerData);