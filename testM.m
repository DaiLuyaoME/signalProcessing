% 测试同一算法不同天线个数下的信噪比
clear;
close all;
%%
p = 3;
m = 10;
d_lamb = 0.5;
theta = deg2rad( [-30,0,30]' );
omega = 2 * pi * d_lamb * sin(theta);
%%
algorithmType = 7;
switch algorithmType
    case 1 % 自己实现的经典 music
        method = @(x,p)classicMUSICDOA(x,p);
    case 2 % 自己实现的root music
        method = @(x,p)rtMUSIC(x,p);
    case 3 % 自己实现的求导 music
        method = @(x,p)derivativeMUSIC(x,p);
    case 4 % matlab自带的经典music
        method = @(x,p)classicMUSICDOA(x,p,1);
    case 5 % matlab自带的root music， rootmusic和rootmusicdoa函数均可
        method = @(x,p)rootmusic(x,p);
    case 6 % 自己实现的esprit
        method = @(x,p)ESPRIT(x,p);
    case 7 % MATLAB自带的esprit,因为该函数要求输入相关函数矩阵，为了保持接口一致性，又封装了一层
        method = @(x,p)espDOA(x,p);
end


%% generate signal
SNR = linspace(0.1,30,50)';
num = numel(SNR);
iterNum = 10;
mBuffer = 10:5:40;
numM = numel(mBuffer);
dataBuffer = cell(numM,1);
for k = 1:numM
    m =mBuffer(k);
    mseBuffer = zeros(num,p);
    for i = 1:num
        tempMSE = 0;
        for j = 1:iterNum
            [x,noise] = dataGenerator(p,m,d_lamb,theta,SNR(i));
            result = method(x,p);
            thetaHat = sort(angle(result));
            if algorithmType > 4
                thetaHat = sort(result);
            end
            thetaHat = asin(thetaHat ./ (2 * pi * d_lamb) );
            if algorithmType == 7
                thetaHat = deg2rad(sort(result));
            end
            tempMSE = tempMSE + (theta - thetaHat).^2;
        end
        tempMSE = sqrt(tempMSE / iterNum);
        mseBuffer(i,:) = tempMSE;
    end
    dataBuffer{k} = mseBuffer;
end
%%
% figure;
% for i = 1:3
%     subplot(3,1,i);plot(SNR,mseBuffer(:,i));
% end
% figure;plot(SNR,sum(mseBuffer,2));
figure;
X = [];Y = [];
for i = 1:numM
%     plot(SNR,sum(dataBuffer{i},2));hold on;
 X = [X,SNR]; Y = [Y,sum(dataBuffer{i},2)];
end
plotM(X,Y);

