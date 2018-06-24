function result = derivativeMUSIC(data,p,plotFlag)
if nargin == 2
    plotFlag = 0;
end
% 求解噪声子空间
method = 'modified'; % 注意相关函数的估计方法的选取对结果有很大的影响；
% method = 'autocorrelation';
% method = 'covariance';
% method = 'postwindowed';
% method = 'prewindowed';
m = numel(data);
[~,R] = corrmtx(data,m-1,method); % 估计相关函数矩阵
% R = data * data';
[V,D] = eig(R);
% Uw = V(:,1:end - (p-1)); % 噪声子空间
Uw = findUw(D,V,p);

[n,~] = size(Uw);
A = Uw * Uw';
A = A * diag(0:n-1);
A = fliplr(A);

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
ylabel('Im');xlabel('Re');grid on;title('Derivative MUSIC');set(gca,'FontSize',14);
axis equal;
end
[~,index] = sort(abs(abs(r)-1));
result = r(index(1:p));



end
