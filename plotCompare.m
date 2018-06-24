function plotCompare(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  x ���ݵ�����
%  YMATRIX1:  y ���ݵľ���

%  �� MATLAB �� 24-Jun-2018 19:54:17 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ʹ�� plot �ľ������봴������
plot1 = plot(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','����MUSIC','Marker','diamond');
set(plot1(2),'DisplayName','��MUSIC','Marker','o');
set(plot1(3),'DisplayName','Root MUSIC','Marker','x');
set(plot1(4),'DisplayName','ESPRIT','Marker','square');

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

