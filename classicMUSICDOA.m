function result = classicMUSICDOA(data,p,methodFlag)
if nargin == 2
    methodFlag = 0;
end
switch methodFlag
    case 0
        [pxx,w] = classicMUSIC(data,p,1024);
    case 1
        [pxx,w] = pmusic(data,p,1024);
end
num = numel(w);
index = 1:num;
interval1 = 1:floor(0.1*num);
interval2 = floor(0.2 * num) : floor(0.3 * num);
interval3 = floor(0.7 * num) : floor(0.8 * num);

[~,index] = max(pxx(interval1));tempW = w(interval1); result(1) = tempW(index);
[~,index] = max(pxx(interval2));tempW = w(interval2); result(2) = tempW(index);
[~,index] = max(pxx(interval3));tempW = w(interval3); result(3) = tempW(index);
result = exp(1j * result)';


end