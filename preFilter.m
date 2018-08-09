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
%%
figure;plot([p_ave,p_non]);
%%
close all;
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
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
temp1 = filter(dataFilter,p_non);
temp2 = filter(dataFilter,p_ave);
figure;plot([temp2,temp1],'LineWidth',2);
%%
figure;periodogram(pos1 - mean(pos1));
figure;periodogram(pos2 - mean(pos2));