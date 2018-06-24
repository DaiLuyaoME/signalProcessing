function plotSpectral(X1, Y1)
%CREATEFIGURE(X1, Y1)
%  X1:  x ���ݵ�����
%  Y1:  y ���ݵ�����

%  �� MATLAB �� 24-Jun-2018 09:02:48 �Զ�����

% ���� figure
% figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ���� plot
plot(X1,Y1,'LineWidth',2);

% ���� ylabel
ylabel('Power (dB)');

% ���� xlabel
xlabel('Normalized Frequency  (\times \pi rad/sample)');

box(axes1,'on');
grid on;
% ������������������
set(axes1,'FontSize',14);
