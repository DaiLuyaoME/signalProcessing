close all;
%%
filteredPowerDataZeroPhaseError = filtfilt(dataFilter,powerData);
figure;plot([powerData,filteredPowerData,filteredPowerDataZeroPhaseError],'LineWidth',2);
h = legend('ԭʼ����','��ͨ�˲�','����λ����ͨ�˲�');set(gca,'FontSize',14);
h.Location = 'best';
xlabel('������');ylabel('�������');set(gca,'FontSize',14);axis tight;
[x,y] = ginput(2);

%%
x = floor(sort(x));
y = sort(y);
%%
[min1,time1] = min( filteredPowerData( x(1) : x(2) ) );
[min2,time2] = min( filteredPowerDataZeroPhaseError( x(1) : x(2) ) );
fs = 49;
Ts = 1/fs;

delay = time1 - time2;
timeDelay = delay * Ts;
fprintf('delay count is %d, delay time is %d \n',delay,timeDelay);
% disp('\n');

