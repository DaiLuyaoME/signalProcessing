function [x,noise] = dataGenerator(p,m,d_lamb,theta,SNR)
% p : 线谱个数；
% m : 天线个数
% d_lamb : d/lambda
% theta : 方位角
% SNR ： 信噪比，单位为dB，10log

omega = 2 * pi * d_lamb * sin(theta);
snr = db2pow(SNR);
%% generate noise
noisePower = 0.12;
u1 = sqrt(noisePower) * randn(m,1);
u2 = sqrt(noisePower) * randn(m,1);
noise = u1 + 1j * u2;
%% generate signal
temp = zeros(1,m);
temp(1:p) = exp(1j * omega);
tempA = transpose ( fliplr ( vander(temp) ) );
A = tempA( :, 1:p);
signalPower = sqrt( noisePower * 2 * snr);               
s = signalPower * ones(p,1);
x = A * s + noise;

end
