function plotM(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  x 数据的向量
%  YMATRIX1:  y 数据的矩阵

%  由 MATLAB 于 24-Jun-2018 16:59:27 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 使用 plot 的矩阵输入创建多行
plot1 = plot(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','m = 10','Marker','o');
set(plot1(2),'DisplayName','m = 15','Marker','x');
set(plot1(3),'DisplayName','m = 20','Marker','diamond');
set(plot1(4),'DisplayName','m = 25','Marker','square');
set(plot1(5),'DisplayName','m = 30','Marker','pentagram');
set(plot1(6),'DisplayName','m = 35','Marker','hexagram');
set(plot1(7),'DisplayName','m = 40','Marker','+');

% 创建 ylabel
ylabel('MSE');

% 创建 xlabel
xlabel('SNR (dB)');

box(axes1,'on');
% 设置其余坐标区属性
set(axes1,'FontSize',14);
% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',14);

