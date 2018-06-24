function plotMSE(X1, data)
%CREATEFIGURE(X1, Y1, Y2, Y3)
%  X1:  x 数据的向量
%  Y1:  y 数据的向量
%  Y2:  y 数据的向量
%  Y3:  y 数据的向量

%  由 MATLAB 于 24-Jun-2018 15:55:32 自动生成

% 创建 figure
figure1 = figure;
Y1 = data(:,1);Y2 = data(:,2); Y3 = data(:,3);
% 创建 subplot
subplot1 = subplot(3,1,1,'Parent',figure1);
hold(subplot1,'on');

% 创建 plot
plot(X1,Y1,'Parent',subplot1,'DisplayName','MSE(\theta_{1})','Marker','o',...
    'LineWidth',2);

% 创建 ylabel
ylabel('MSE');

% 创建 xlabel
xlabel('SNR (dB)');

box(subplot1,'on');
% 创建 legend
legend1 = legend(subplot1,'show');
set(legend1,'FontSize',12);

% 创建 subplot
subplot2 = subplot(3,1,2,'Parent',figure1);
hold(subplot2,'on');

% 创建 plot
plot(X1,Y2,'Parent',subplot2,'DisplayName','MSE(\theta_{2})','Marker','o',...
    'LineWidth',2);

% 创建 ylabel
ylabel('MSE');

% 创建 xlabel
xlabel('SNR (dB)');

box(subplot2,'on');
% 创建 legend
legend2 = legend(subplot2,'show');
set(legend2,'FontSize',12);

% 创建 subplot
subplot3 = subplot(3,1,3,'Parent',figure1);
hold(subplot3,'on');

% 创建 plot
plot(X1,Y3,'Parent',subplot3,'DisplayName','MSE(\theta_{3})','Marker','o',...
    'LineWidth',2);

% 创建 ylabel
ylabel('MSE');

% 创建 xlabel
xlabel('SNR (dB)');

box(subplot3,'on');
% 创建 legend
legend3 = legend(subplot3,'show');
set(legend3,'FontSize',12);

