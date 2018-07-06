figure;
num = numel(data);
numSize = zeros(num,1);
for i = 1 : num
    plot(data{i});
    hold on;
    numSize(i) = numel(data{i});
end
%%
fs = 49;
Ts = 1/fs;
%%
