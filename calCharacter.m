function result = calCharacter(data,windowsize,startPoint,methodType)
%  data: data to cal;
% windosize: size of window;
% startPoint: position to start
% methodType: 'mean' , 'ma', 'msd'
	result = zeros(size(data));
	num = numel(result);
	switch methodType
	case 'ma'
		calFun = @(x)calMA(x);
	case 'mean'
		calFun = @(x)mean(x);
	case 'msd'
		calFun = @(x)calMSD(x);
	end

	for i = startPoint:num
		result(i) = calFun(data((i - windowsize + 1):i));
	end



function ma = calMA(data)
	ma = mean(abs(data));
end

function msd = calMSD(data)

	temp = mean(data);
	msd = sqrt(mean((data-temp).^2));
end



end