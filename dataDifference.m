%%
originalData = powerData;
firDev = diff(originalData);
secDev = diff(originalData,2);
%% 一阶导数绘制，未滤波
figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
ylabel('电机功率');
yyaxis right;
plot(firDevZeroPhase,'DisplayName','一阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(firDevZeroPhase)),'DisplayName','0刻度线');
ylabel('一阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
ylabel('电机功率');
yyaxis right;
plot(firDev,'DisplayName','一阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(firDev)),'DisplayName','0刻度线');
ylabel('一阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

%% 二阶导数绘制
figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(originalDataZeroPhase,'DisplayName','零相位误差滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(secDevZeroPhase,'DisplayName','二阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(secDevZeroPhase)),'DisplayName','0刻度线');
ylabel('二阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';
figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(originalDataZeroPhase,'DisplayName','滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(secDev,'DisplayName','二阶导数','LineWidth',2);grid on;hold on;plot(zeros(size(secDev)),'DisplayName','0刻度线');
ylabel('二阶导数');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';
%% 一阶导数，滤波
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
% dataFilter = designfilt('lowpassfir', 'FilterOrder', 17, 'PassbandFrequency', .05, 'StopbandFrequency', 0.06);
filteredFirDev = filter(dataFilter,firDev);
filteredFirDevZeroPhase = filtfilt(dataFilter,firDev);

figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(filteredPowerDataZeroPhaseError,'DisplayName','零相位误差滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(filteredFirDevZeroPhase,'DisplayName','一阶导数(零相位误差滤波)','LineWidth',2);grid on;hold on;plot(zeros(size(filteredFirDevZeroPhase)),'DisplayName','0刻度线');
ylabel('一阶导数(零相位误差滤波)');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
ylabel('电机功率');
yyaxis right;
plot(filteredFirDev,'DisplayName','一阶导数(低通滤波)','LineWidth',2);grid on;hold on;plot(zeros(size(filteredFirDev)),'DisplayName','0刻度线');
ylabel('一阶导数(低通滤波)');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

%% 二阶导数，滤波
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .002, 'PassbandRipple', 0.01);
% dataFilter = designfilt('lowpassfir', 'FilterOrder', 17, 'PassbandFrequency', .05, 'StopbandFrequency', 0.06);
filteredFirDev = filter(dataFilter,secDev);
filteredFirDevZeroPhase = filtfilt(dataFilter,secDev);

figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
hold on ;
plot(filteredPowerDataZeroPhaseError,'DisplayName','零相位误差滤波后数据','LineWidth',2,'Color','r'); ylabel('电机功率');
yyaxis right;
plot(filteredFirDevZeroPhase,'DisplayName','二阶导数(零相位误差滤波)','LineWidth',2);grid on;hold on;plot(zeros(size(filteredFirDevZeroPhase)),'DisplayName','0刻度线');
ylabel('二阶导数(零相位误差滤波)');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';

figure; 
yyaxis left;
plot(powerData,'DisplayName','原始数据');
ylabel('电机功率');
yyaxis right;
plot(filteredFirDev,'DisplayName','二阶导数(低通滤波)','LineWidth',2);grid on;hold on;plot(zeros(size(filteredFirDev)),'DisplayName','0刻度线');
ylabel('二阶导数(低通滤波)');
xlabel('采样点');set(gca,'FontSize',14);
axis tight;
h = legend('show');
h.Location = 'southeast';