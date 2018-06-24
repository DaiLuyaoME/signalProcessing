function result = ESPRIT(data,p)
% ��������ӿռ�
method = 'autocorrelation';
m = numel(data);
[~,R] = corrmtx(data,m-1,method); % ������غ�������
% R = data * data';
[V,D] = eig(R);
% Uw = V(:,1:end - (p-1)); % �����ӿռ�
Us = findUs(D,V,p);
U1 = Us(1:m-2,:);
U2 = Us(2:m-1,:);
T = pinv(U1) * U2;
[~,phi] = eig(T);
result = diag(phi);
result = angle(result);   