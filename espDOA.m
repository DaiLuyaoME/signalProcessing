function result = espDOA(data,p)
method = 'autocorrelation';
m = numel(data);
[~,R] = corrmtx(data,m-1,method); % ������غ�������
result = espritdoa(R,p)';

end
