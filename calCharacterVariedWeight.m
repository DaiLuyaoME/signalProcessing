function result = calCharacterVariedWeight(data,windowsize,startPoint,methodType)
% MSD的计算采取变权重
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
        numData = numel(data);
        linearWeight = (1:numData) / sum(1:numData);
        
        tempWeight = linearWeight;
        msd = sqrt( dot(tempWeight, (data - mean(data)).^2  ));
%         msd = sqrt(mean((data-temp).^2));
    end

    function absError = calAbsError(data)
        absError = mean(abs(data));
%         absError = sum(abs(data - temp));
    end

end