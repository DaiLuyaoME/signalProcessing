function result = espDOA(data,p)
method = 'autocorrelation';
m = numel(data);
[~,R] = corrmtx(data,m-1,method); % 估计相关函数矩阵
result = espritdoa(R,p)';

end
