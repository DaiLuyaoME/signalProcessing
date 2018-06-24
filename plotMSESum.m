function plotMSESum(X1, Y1)
%CREATEFIGURE(X1, Y1)
%  X1:  x 数据的向量
%  Y1:  y 数据的向量

%  由 MATLAB 于 24-Jun-2018 16:02:06 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 plot
plot(X1,Y1,...
    'DisplayName','MSE(\theta_{1}) + MSE(\theta_{2}) + MSE(\theta_{3})',...
    'Marker','o',...
    'LineWidth',2);

% 创建 ylabel
ylabel('MSE');

% 创建 xlabel
xlabel('SNR (dB)');

box(axes1,'on');
% 设置其余坐标区属性
set(axes1,'FontSize',16);
% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',16);

