function powerSpectralAnalysis(data,fs)
switch nargin
    case 1
        [pxx,f] = periodogram(data);
        plot(f,10*log10(pxx),'DisplayName','周期图法');
        hold on;
        [pxx,f] = pwelch(data);
        plot(f,10*log10(pxx),'DisplayName','Welch方法');
        [pxx,f] = pmtm(data);
        plot(f,10*log10(pxx),'DisplayName','mtm方法');
    case 2
        [pxx,f] = periodogram(data,[],[],fs);
        plot(f,10*log10(pxx),'DisplayName','周期图法');
        hold on;
        [pxx,f] = pwelch(data,[],[],[],fs);
        plot(f,10*log10(pxx),'DisplayName','Welch方法');
        [pxx,f] = pmtm(data,[],[],fs);
        plot(f,10*log10(pxx),'DisplayName','mtm方法');
        
        
end
legend show;
set(gca,'FontSize',14)
end