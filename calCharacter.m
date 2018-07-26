function result = calCharacter(data,windowsize,startPoint,methodType)
%  data: data to cal;
% windosize: size of window;
% startPoint: position to start
% methodType: 'mean' , 'ma', 'msd'
result = zeros(size(data));
num = numel(result);
switch methodType
    case 'MA'
        calFun = @(x)calMA(x);
    case 'mean'
        calFun = @(x)mean(x);
    case 'MSD'
        calFun = @(x)calMSD(x);
    case 'MAA'
        calFun = @(x)calAbsError(x);
    case 'MAX'
        calFun = @(x)max(x);
    case 'MIN'
        calFun = @(x)min(x);
end

for i = startPoint:num
    result(i) = calFun(data((i - windowsize + 1):i));
end



    function ma = calMA(data)
        ma = mean(data);
    end

    function msd = calMSD(data)
        temp = mean(data);
        msd = sqrt(mean((data-temp).^2));
    end

    function absError = calAbsError(data)
        absError = mean(abs(data));
%         absError = sum(abs(data - temp));
    end

end