% 测试同一算法不同天线个数下的信噪比
clear;
close all;
%%
p = 3;
m = 45;
d_lamb = 0.5;
theta = deg2rad( [-30,0,30]' );
omega = 2 * pi * d_lamb * sin(theta);
%%
% methodList = { @(x,p)classicMUSICDOA(x,p),@(x,p)rtMUSIC(x,p),@(x,p)derivativeMUSIC(x,p),@(x,p)classicMUSICDOA(x,p,1),@(x,p)rootmusic(x,p),@(x,p)ESPRIT(x,p),@(x,p)espDOA(x,p)};
% 算法列表：（1）经典music；（2）root music；（3）求导music；（4）esprit
methodList = { @(x,p)classicMUSICDOA(x,p,1),@(x,p)derivativeMUSIC(x,p),@(x,p)rootmusic(x,p),@(x,p)ESPRIT(x,p)};
methodNum = numel(methodList);

%% generate signal
SNR = linspace(0.1,30,50)';
num = numel(SNR);
iterNum = 10;
methodBuffer = zeros(num,methodNum);
for k = 1:methodNum
    method = methodList{k};
    mseBuffer = zeros(num,p);
    for i = 1:num
        tempMSE = 0;
        for j = 1:iterNum
            [x,noise] = dataGenerator(p,m,d_lamb,theta,SNR(i));
            result = method(x,p);
            thetaHat = sort(angle(result));
            if k>2
                thetaHat = sort(result);
            end
            thetaHat = asin(thetaHat ./ (2 * pi * d_lamb) );
            tempMSE = tempMSE + (theta - thetaHat).^2;
        end
        tempMSE = sqrt(tempMSE / iterNum);
        mseBuffer(i,:) = tempMSE;
    end
    methodBuffer(:,k) = sum(mseBuffer,2);
end
%%
% figure;
X = repmat(SNR,1,methodNum);
plotCompare(X,methodBuffer);


