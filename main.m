clear;
close all;
%%
p = 3;
m = 20;
d_lamb = 0.5;
theta = deg2rad( [-30,0,30] );
omega = 2 * pi * d_lamb * sin(theta);

%% generate noise
noisePower = 0.12;
u1 = sqrt(noisePower) * randn(m,1);
u2 = sqrt(noisePower) * randn(m,1);
noise = u1 + 1j * u2;
%% generate signal
% dataNum = 100;
SNR = 10; % 20log10 = 20dB 换用db2pow函数
temp = zeros(1,m);
temp(1:p) = exp(1j * omega);
tempA = transpose ( fliplr ( vander(temp) ) );
A = tempA( :, 1:p);
signalPower = sqrt( noisePower * 2 * SNR);               
s = signalPower * ones(p,1);
x = A * s + noise;

%%
[pxx,w] = classicMUSIC(x,p,1024);
figure;plot(w/(2*pi),10*log10(pxx));
figure;pmusic(x,p,1024);

% rootmusic
%%
result = rtMUSIC(x,p);
%%
derivativeMUSIC(x,p);
%%
% 与matlab自带的rootmusicdoa,rootmusic,esprit;




