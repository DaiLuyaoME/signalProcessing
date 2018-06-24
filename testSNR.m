% 测试同一算法不同天线个数下的信噪比
clear;
close all;
%%
p = 3;
m = 20;
d_lamb = 0.5;
theta = deg2rad( [-30,0,30]' );
omega = 2 * pi * d_lamb * sin(theta);
%%
algorithmType = 1;
switch algorithmType
    case 1 % classic music
        method = @(x,p)classicMUSICDOA(x,p);
    case 2 % root music
        method = @(x,p)rtMUSIC(x,p);
    case 3 % derivative music
        method = @(x,p)derivativeMUSIC(x,p);
    case 4 % esprit
        method = 0;
end


%% generate signal
SNR = linspace(0.1,30,50);
num = numel(SNR);
iterNum = 10;
mseBuffer = zeros(num,p);
for i = 1:num
    tempMSE = 0;
    for j = 1:iterNum
        [x,noise] = dataGenerator(p,m,d_lamb,theta,SNR(i));
        result = method(x,p);
        thetaHat = sort(angle(result));
        thetaHat = asin(thetaHat ./ (2 * pi * d_lamb) );
        tempMSE = tempMSE + (theta - thetaHat).^2;
    end
    tempMSE = sqrt(tempMSE / iterNum);
    mseBuffer(i,:) = tempMSE;
end
%%
plotMSE(SNR,mseBuffer);
plotMSESum(SNR,sum(mseBuffer,2));
