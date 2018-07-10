%%
originalData = powerData;
firDev = diff(originalData);
secDev = diff(originalData,2);
%% һ�׵������ƣ�δ�˲�
figure; 
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
ylabel('�������');
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
ylabel('�������');
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
%% һ�׵������˲�
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
% dataFilter = designfilt('lowpassfir', 'FilterOrder', 17, 'PassbandFrequency', .05, 'StopbandFrequency', 0.06);
filteredFirDev = filter(dataFilter,firDev);
filteredFirDevZeroPhase = filtfilt(dataFilter,firDev);

figure; 
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(filteredPowerDataZeroPhaseError,'DisplayName','����λ����˲�������','LineWidth',2,'Color','r'); ylabel('�������');
yyaxis right;
plot(filteredFirDevZeroPhase,'DisplayName','һ�׵���(����λ����˲�)','LineWidth',2);grid on;hold on;plot(zeros(size(filteredFirDevZeroPhase)),'DisplayName','0�̶���');
ylabel('һ�׵���(����λ����˲�)');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

figure; 
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
ylabel('�������');
yyaxis right;
plot(filteredFirDev,'DisplayName','һ�׵���(��ͨ�˲�)','LineWidth',2);grid on;hold on;plot(zeros(size(filteredFirDev)),'DisplayName','0�̶���');
ylabel('һ�׵���(��ͨ�˲�)');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

%% ���׵������˲�
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .002, 'PassbandRipple', 0.01);
% dataFilter = designfilt('lowpassfir', 'FilterOrder', 17, 'PassbandFrequency', .05, 'StopbandFrequency', 0.06);
filteredFirDev = filter(dataFilter,secDev);
filteredFirDevZeroPhase = filtfilt(dataFilter,secDev);

figure; 
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
hold on ;
plot(filteredPowerDataZeroPhaseError,'DisplayName','����λ����˲�������','LineWidth',2,'Color','r'); ylabel('�������');
yyaxis right;
plot(filteredFirDevZeroPhase,'DisplayName','���׵���(����λ����˲�)','LineWidth',2);grid on;hold on;plot(zeros(size(filteredFirDevZeroPhase)),'DisplayName','0�̶���');
ylabel('���׵���(����λ����˲�)');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

figure; 
yyaxis left;
plot(powerData,'DisplayName','ԭʼ����');
ylabel('�������');
yyaxis right;
plot(filteredFirDev,'DisplayName','���׵���(��ͨ�˲�)','LineWidth',2);grid on;hold on;plot(zeros(size(filteredFirDev)),'DisplayName','0�̶���');
ylabel('���׵���(��ͨ�˲�)');
xlabel('������');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';