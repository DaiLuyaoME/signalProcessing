%% ��ȡ����
% ��ȡ���ݼ�2��һ�������ļ�
data = csvread('./data/dataSet2/E8L030#13.csv',2,1);
powerData = data(:,1);  % ��������ź�
pos1 = data(:,2); % ����λ��
pos2 = data(:,3); % �ڶ��Ƕ�
%% Ԥ����
e0 = 190;
e_cup=630;
L=530;

% k1=22;   
k2=55;   
k1=17;   
p_ave = powerData;
%���ݴ���

e1=e_cup-pos1;
e2=2*L*sin((60-pos2)/360*pi);
p_non=(p_ave-k1*e2/175-k2)./e1*e0;   %��һ��
%% Ԥ����ǰ��ʱ������
figure;plot([p_ave,p_non],'linewidth',2);
ylabel('�������');
xlabel('������');
set(gca,'fontsize',14);
legend('ԭʼ�ź�','Ԥ�����');
axis tight;
%% Ԥ����ǰ�����׷���
% close all;
figure;
pwelch([p_ave - mean(p_ave), p_non - mean(p_non)]);
tempAxe = gca;
set(tempAxe,'fontsize',14);
h1 = tempAxe.Children(2);%ע��children��˳���뻭ͼ��˳���Ƿ��ģ�
h2 = tempAxe.Children(1);
h1.LineWidth = 2;
h2.LineWidth = 2;
h1.DisplayName = 'ԭʼ�ź�';
h2.DisplayName = 'Ԥ�����';
legend('show');
%%
% dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
% temp1 = filter(dataFilter,p_non);
% temp2 = filter(dataFilter,p_ave);
% figure;plot([temp2,temp1],'LineWidth',2);
%% ����λ�úͰڶ��Ƕ��ź�Ƶ�ʳɷַ���
figure;periodogram(pos1 - mean(pos1));
figure;periodogram(pos2 - mean(pos2));