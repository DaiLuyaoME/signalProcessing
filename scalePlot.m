function scalePlot(data)

temp = data(:,1);
num = size(data,2);
% plot(data(:,1));hold on;
for i = 1:num
    ratio = max(abs(temp)) / max(abs(data(:,i)));
    plot(data(:,i) * ratio,'LineWidth',2);
    hold on;
end

end