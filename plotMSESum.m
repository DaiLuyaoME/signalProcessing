function plotMSESum(X1, Y1)
%CREATEFIGURE(X1, Y1)
%  X1:  x ���ݵ�����
%  Y1:  y ���ݵ�����

%  �� MATLAB �� 24-Jun-2018 16:02:06 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ���� plot
plot(X1,Y1,...
    'DisplayName','MSE(\theta_{1}) + MSE(\theta_{2}) + MSE(\theta_{3})',...
    'Marker','o',...
    'LineWidth',2);

% ���� ylabel
ylabel('MSE');

% ���� xlabel
xlabel('SNR (dB)');

box(axes1,'on');
% ������������������
set(axes1,'FontSize',16);
% ���� legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',16);

