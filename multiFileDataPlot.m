%% �������ݼ���ȫ�������ļ�
loadData;
%% �������ļ�ԭʼ�����źŻ���
figure;
num = numel(data);
numSize = zeros(num,1);
for i = 1 : num
    plot(data{i});
    hold on;
    numSize(i) = numel(data{i});
    dataPre{i} = dataPreProcess(data{i},pos1{i},pos2{i},17);
end
xlabel('������');ylabel('�������');set(gca,'FontSize',14);
% �趨x��Ļ��Ʒ�Χ
xlim([500,3000]);
% axis tight;
%% ����˲���
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
%% �������ļ�ʵʱ�˲�������λ�˲��������
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
xlabel('������');ylabel('ʵʱ�˲���������');set(gca,'FontSize',14);
% axis tight;
% �趨x��Ļ��Ʒ�Χ
xlim([1000,3000]);

figure;
for i = 1 : num
    plot(filteredPowerDataZeroPhaseError{i},'LineWidth',2);
    hold on;
end
xlabel('������');ylabel('����λ�˲���������');set(gca,'FontSize',14);
% axis tight;
% �趨x��Ļ��Ʒ�Χ
xlim([1000,3000]);
% filteredPowerData = filter(dataFilter,powerData);
%% �������ļ������׷���
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