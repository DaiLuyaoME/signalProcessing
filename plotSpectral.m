function plotSpectral(X1, Y1)
%CREATEFIGURE(X1, Y1)
%  X1:  x 数据的向量
%  Y1:  y 数据的向量

%  由 MATLAB 于 24-Jun-2018 09:02:48 自动生成

% 创建 figure
% figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 plot
plot(X1,Y1,'LineWidth',2);

% 创建 ylabel
ylabel('Power (dB)');

% 创建 xlabel
xlabel('Normalized Frequency  (\times \pi rad/sample)');

box(axes1,'on');
grid on;
% 设置其余坐标区属性
set(axes1,'FontSize',14);
