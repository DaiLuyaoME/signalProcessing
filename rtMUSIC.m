function result = rtMUSIC(data,p,plotFlag)
if nargin == 2
    plotFlag = 0;
end

% ��������ӿռ�
% method = 'modified'; % ע����غ����Ĺ��Ʒ�����ѡȡ�Խ���кܴ��Ӱ�죻
method = 'autocorrelation';
% method = 'covariance';
% method = 'postwindowed';
% method = 'prewindowed';
m = numel(data);
[~,R] = corrmtx(data,m-1,method); % ������غ�������
% R = data * data';
[V,D] = eig(R);
% Uw = V(:,1:end - (p-1)); % �����ӿռ�
Uw = findUw(D,V,p);

A = Uw * Uw';
A = fliplr(A);
[n,~] = size(A);
coef = zeros( 2 * n -1,1);
for i = 1:n
    u = A(:,i);
    v = zeros(n,1);
    v(i) = 1;
    coef = coef + conv(u,v);
end
r = roots(coef);
if plotFlag == 1
    figure;plot(r,'Marker','o','LineWidth',2,'LineStyle','none');hold on;
    plot(exp( 1j * linspace(0,2*pi,100)),'LineWidth',2);
    ylabel('Im');xlabel('Re');grid on;title('Root MUSIC');set(gca,'FontSize',14);
    axis equal;
end

[~,index] = sort(abs(abs(r)-1));
temp = r(index(1:2*p));
result = temp(abs(temp)<1);
if (numel(result) ~= p)
    result = result(1:p);
end


end