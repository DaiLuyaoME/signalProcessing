% clear;
close all;
%%
p = 3;
m = 10;
d_lamb = 0.5;
theta = deg2rad( [-30,0,30]' );
omega = 2 * pi * d_lamb * sin(theta);

%% generate signal
SNR = 10;
[x,noise] = dataGenerator(p,m,d_lamb,theta,SNR);

%%
[pxx,w] = classicMUSIC(x,p,1024);
plotSpectral(w/pi,10*log10(pxx));
% title('自己实现');
[pxx,w]= pmusic(x,p,1024);
plotSpectral(w/pi,10*log10(pxx));
% rootmusic
%%
result = rtMUSIC(x,p,1);
numel(result);
%%
% [w,pow] = rootmusic(x,3);
% figure;plot((sqrt(pow)/2).* exp(1j .* w),'Marker','o','LineWidth',2,'LineStyle','none');hold on;
% plot(exp( 1j * linspace(0,2*pi,100)),'LineWidth',2);
% ylabel('Im');xlabel('Re');grid on;title('Root MUSIC');set(gca,'FontSize',14);
% axis equal;
%%
result = derivativeMUSIC(x,p);
%%
% 与matlab自带的rootmusicdoa,rootmusic,esprit;




