% 测试同一算法不同天线个数下的信噪比
clear;
close all;
%%
p = 3;
m = 20;
d_lamb = 0.5;
theta = deg2rad( [-30,0,30]' );
omega = 2 * pi * d_lamb * sin(theta);

%% generate signal
SNR = linspace(0.1,30,100);
num = numel(SNR);
iterNum = 100;
mseBuffer = zeros(num,p);

for i = 1:num
    tempMSE = 0;
    for j = 1:iterNum
        [x,noise] = dataGenerator(p,m,d_lamb,theta,SNR(i));
        result = rtMUSIC(x,p);
        thetaHat = sort(angle(result));
        thetaHat = asin(thetaHat ./ (2 * pi * d_lamb) );
        tempMSE = tempMSE + (theta - thetaHat).^2;
    end
    tempMSE = sqrt(tempMSE / iterNum);
    mseBuffer(i,:) = tempMSE;
end
%%
figure;
for i = 1:3
    subplot(3,1,i);plot(SNR,mseBuffer(:,i));
end
figure;plot(SNR,sum(mseBuffer,2));
