clear;
close all;
%%
p = 3;
m = 10;
d_lamb = 0.5;
theta = deg2rad( [-30,0,30] );
omega = 2 * pi * d_lamb * sin(theta);

%% generate signal
SNR = 10;
[x,noise] = dataGenerator(p,m,d_lamb,theta,SNR);

%%
[pxx,w] = classicMUSIC(x,p,1024);
plotSpectral(w/pi,10*log10(pxx));
figure;pmusic(x,p,1024);

% rootmusic
%%
result = rtMUSIC(x,p);
%%
result = derivativeMUSIC(x,p);
%%
% 与matlab自带的rootmusicdoa,rootmusic,esprit;




