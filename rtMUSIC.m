function result = rtMUSIC(data,p)
% ��������ӿռ�
method = 'autocorrelation';
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
figure;plot(r,'o');hold on;
plot(exp( 1j * linspace(0,2*pi,100)));
axis equal;

[~,index] = sort(abs(abs(r)-1));
temp = r(index(1:2*p));
result = temp(abs(temp)<1);
    



end