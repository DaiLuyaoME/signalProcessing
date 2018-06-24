function plotMSE(X1, data)
%CREATEFIGURE(X1, Y1, Y2, Y3)
%  X1:  x ���ݵ�����
%  Y1:  y ���ݵ�����
%  Y2:  y ���ݵ�����
%  Y3:  y ���ݵ�����

%  �� MATLAB �� 24-Jun-2018 15:55:32 �Զ�����

% ���� figure
figure1 = figure;
Y1 = data(:,1);Y2 = data(:,2); Y3 = data(:,3);
% ���� subplot
subplot1 = subplot(3,1,1,'Parent',figure1);
hold(subplot1,'on');

% ���� plot
plot(X1,Y1,'Parent',subplot1,'DisplayName','MSE(\theta_{1})','Marker','o',...
    'LineWidth',2);

% ���� ylabel
ylabel('MSE');

% ���� xlabel
xlabel('SNR (dB)');

box(subplot1,'on');
% ���� legend
legend1 = legend(subplot1,'show');
set(legend1,'FontSize',12);

% ���� subplot
subplot2 = subplot(3,1,2,'Parent',figure1);
hold(subplot2,'on');

% ���� plot
plot(X1,Y2,'Parent',subplot2,'DisplayName','MSE(\theta_{2})','Marker','o',...
    'LineWidth',2);

% ���� ylabel
ylabel('MSE');

% ���� xlabel
xlabel('SNR (dB)');

box(subplot2,'on');
% ���� legend
legend2 = legend(subplot2,'show');
set(legend2,'FontSize',12);

% ���� subplot
subplot3 = subplot(3,1,3,'Parent',figure1);
hold(subplot3,'on');

% ���� plot
plot(X1,Y3,'Parent',subplot3,'DisplayName','MSE(\theta_{3})','Marker','o',...
    'LineWidth',2);

% ���� ylabel
ylabel('MSE');

% ���� xlabel
xlabel('SNR (dB)');

box(subplot3,'on');
% ���� legend
legend3 = legend(subplot3,'show');
set(legend3,'FontSize',12);

