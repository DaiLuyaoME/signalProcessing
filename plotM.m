function plotM(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  x ���ݵ�����
%  YMATRIX1:  y ���ݵľ���

%  �� MATLAB �� 24-Jun-2018 16:59:27 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ʹ�� plot �ľ������봴������
plot1 = plot(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','m = 10','Marker','o');
set(plot1(2),'DisplayName','m = 15','Marker','x');
set(plot1(3),'DisplayName','m = 20','Marker','diamond');
set(plot1(4),'DisplayName','m = 25','Marker','square');
set(plot1(5),'DisplayName','m = 30','Marker','pentagram');
set(plot1(6),'DisplayName','m = 35','Marker','hexagram');
set(plot1(7),'DisplayName','m = 40','Marker','+');

% ���� ylabel
ylabel('MSE');

% ���� xlabel
xlabel('SNR (dB)');

box(axes1,'on');
% ������������������
set(axes1,'FontSize',14);
% ���� legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',14);

