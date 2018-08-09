%% 读取数据
% 读取数据集2的一个数据文件
data = csvread('./data/dataSet2/E8L030#13.csv',2,1);
powerData = data(:,1);  % 电机功率信号
pos1 = data(:,2); % 往复位置
pos2 = data(:,3); % 摆动角度
%% 预处理
e0 = 190;
e_cup=630;
L=530;

% k1=22;   
k2=55;   
k1=17;   
p_ave = powerData;
%数据处理

e1=e_cup-pos1;
e2=2*L*sin((60-pos2)/360*pi);
p_non=(p_ave-k1*e2/175-k2)./e1*e0;   %归一化
%% 预处理前后时域曲线
figure;plot([p_ave,p_non],'linewidth',2);
ylabel('电机功率');
xlabel('采样点');
set(gca,'fontsize',14);
legend('原始信号','预处理后');
axis tight;
%% 预处理前后功率谱分析
% close all;
figure;
pwelch([p_ave - mean(p_ave), p_non - mean(p_non)]);
tempAxe = gca;
set(tempAxe,'fontsize',14);
h1 = tempAxe.Children(2);%注意children的顺序与画图的顺序是反的！
h2 = tempAxe.Children(1);
h1.LineWidth = 2;
h2.LineWidth = 2;
h1.DisplayName = '原始信号';
h2.DisplayName = '预处理后';
legend('show');
%%
% dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
% temp1 = filter(dataFilter,p_non);
% temp2 = filter(dataFilter,p_ave);
% figure;plot([temp2,temp1],'LineWidth',2);
%% 往复位置和摆动角度信号频率成分分析
figure;periodogram(pos1 - mean(pos1));
figure;periodogram(pos2 - mean(pos2));