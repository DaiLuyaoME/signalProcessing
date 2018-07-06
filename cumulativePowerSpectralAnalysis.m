function cumulativePowerSpectralAnalysis(data,fs)
switch nargin
    case 1
        [pxx,f] = periodogram(data);
        h = semilogx(f,cumsum(pxx));
        h.DisplayName = '����ͼ��';
        %         plot(f,10*log10(pxx),'DisplayName','����ͼ��');
        hold on;
        [pxx,f] = pwelch(data);
        h = semilogx(f,cumsum(pxx));
        h.DisplayName = 'Welch����';
        %         plot(f,10*log10(pxx),'DisplayName','Welch����');
        [pxx,f] = pmtm(data);
        %         plot(f,10*log10(pxx),'DisplayName','mtm����');
        h = semilogx(f,cumsum(pxx));
        h.DisplayName = 'mtm����';
    case 2
        [pxx,f] = periodogram(data,[],[],fs);
        h = semilogx(f,cumsum(pxx));
        h.DisplayName = '����ͼ��';
        hold on;
        [pxx,f] = pwelch(data,[],[],[],fs);
        h = semilogx(f,cumsum(pxx));
        h.DisplayName = 'Welch����';
        [pxx,f] = pmtm(data,[],[],fs);
        h = semilogx(f,cumsum(pxx));
        h.DisplayName = 'mtm����';
        
        
end
legend show;
set(gca,'FontSize',14)
end