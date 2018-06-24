clear;
close all;
%%
p = 3;
m = 10;
d_lamb = 0.5;
theta = deg2rad( [-30,0,30] );
omega = 2 * pi * d_lamb * sin(theta);

%% generate noise
noisePower = 0.12;
u1 = sqrt(noisePower) * randn(m,1);
u2 = sqrt(noisePower) * randn(m,1);
noise = u1 + 1j * u2;
%% generate signal
[x,noise] = dataGenerator(p,m,d_lamb,theta,SNR);

%%
[pxx,w] = classicMUSIC(x,p,1024);
figure;plotSpectral(w/pi,10*log10(pxx));
figure;pmusic(x,p,1024);

% rootmusic
%%
result = rtMUSIC(x,p);
%%
result = derivativeMUSIC(x,p);
%%
% 与matlab自带的rootmusicdoa,rootmusic,esprit;




