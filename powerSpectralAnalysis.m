function powerSpectralAnalysis(data,fs)
switch nargin
    case 1
        [pxx,f] = periodogram(data);
        plot(f,10*log10(pxx),'DisplayName','����ͼ��');
        hold on;
        [pxx,f] = pwelch(data);
        plot(f,10*log10(pxx),'DisplayName','Welch����');
        [pxx,f] = pmtm(data);
        plot(f,10*log10(pxx),'DisplayName','mtm����');
    case 2
        [pxx,f] = periodogram(data,[],[],fs);
        plot(f,10*log10(pxx),'DisplayName','����ͼ��');
        hold on;
        [pxx,f] = pwelch(data,[],[],[],fs);
        plot(f,10*log10(pxx),'DisplayName','Welch����');
        [pxx,f] = pmtm(data,[],[],fs);
        plot(f,10*log10(pxx),'DisplayName','mtm����');
        
        
end
legend show;
set(gca,'FontSize',14)
end