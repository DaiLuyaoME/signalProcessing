function result = ESPRIT(data,p)
% 求解噪声子空间
method = 'autocorrelation';
m = numel(data);
[~,R] = corrmtx(data,m-1,method); % 估计相关函数矩阵
% R = data * data';
[V,D] = eig(R);
% Uw = V(:,1:end - (p-1)); % 噪声子空间
Us = findUs(D,V,p);
U1 = Us(1:m-2,:);
U2 = Us(2:m-1,:);
T = pinv(U1) * U2;
[~,phi] = eig(T);
result = diag(phi);
result = angle(result);   