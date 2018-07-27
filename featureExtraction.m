%% ͨ���趨deadtime��ȡMSD����
close all;
deadtime = 1700;
tempFlag = 2;
num = numel(data);
tempData = cell(size(data));
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{i});
            dataName = '����λ�˲�������';
        case 2
            tempData{i} = filter(dataFilter,data{i});
            dataName = '�˲�������';
    end
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 30;
methodType = 'MSD';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize,startPoint,methodType);
end

figure;
for i = 1:num
    plot(result{i},'LineWidth',2);
    hold on;
end

ylabel(methodType);
xlabel('������');set(gca,'FontSize',14);
axis tight;
% legend('show');
xlim([deadtime,3000]);
%% ʵʱ�˲���MSD��Сֵ�㣬���ݼ�2
tempIndex = zeros(num,1);
for i = 1:num
    temp = result{i};
    temp = temp(2100:min(2600,numel(temp)));
    [~,tempIndex(i)] = min(temp);
end
tempIndex = tempIndex + 2100 -1;
%% ��������MSD ����һ�׵�������
% ��Ҫ������tempTest���õ��������ݵ�MSD
deadtime = 1700;
tempResult = result;
figure;
yyaxis left;
plot(tempResult,'LineWidth',2,'DisplayName','��ȡ������');
xlabel('������');
ylabel('MSD');
hold on;
yyaxis right;
plot(diff(tempResult),'LineWidth',2,'displayname','һ�׵���');
hold on; plot(zeros(size(tempResult)),'LineWidth',2,'displayName','0�̶���','LineStyle','--','color','black');
ylabel('MSDһ�׵���');
legend show;
xlim([deadtime,numel(tempResult)]);
set(gca,'fontsize',14);
figure;findpeaks(tempResult);
%% ��������MSD��Сֵ����
deadtime = 1700;
[loc,val] = findNotch(result,0.1);
val = val(loc>deadtime);
loc = loc(loc>deadtime);
figure;
plot(result,'DisplayName','MSD','LineWidth',4);
hold on;
plot(loc,val,'o','linewidth',4);
xlim([deadtime,numel(result)]);
xlabel('������');
ylabel('MSD');
set(gca,'Fontsize',14);
%% ��������MSD����ֵ����
deadtime = 1700;
[loc,val] = findPeak(result,1);
val = val(loc>deadtime);
loc = loc(loc>deadtime);
figure;
plot(result,'DisplayName','MSD','LineWidth',4);
hold on;
plot(loc,val,'diamond','linewidth',4);
xlim([deadtime,numel(result)]);
xlabel('������');
ylabel('MSD');
set(gca,'Fontsize',14);
%% �������ļ�MSD����ֵ�ͼ�Сֵ������
close all;
deadtime = 1700;
tempFlag = 1;
num = numel(data);
tempData = cell(size(data));
dataFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .003, 'PassbandRipple', 0.01);
for i = 1:num
    switch tempFlag
        case 1
            tempData{i} = filtfilt(dataFilter,data{i});
            dataName = '����λ�˲�������';
        case 2
            tempData{i} = filter(dataFilter,data{i});
            dataName = '�˲�������';
    end
end
% tempData = diff(filteredPowerData);
startPoint = 300;
windowSize = 60;
methodType = 'MSD';

result = cell(size(tempData));

for i = 1:num
result{i} = calCharacter(tempData{i},windowSize,startPoint,methodType);
end

distanceLoc  = zeros(numel(result),1);
distanceVal = zeros(numel(result),1);

for i = 1:num
    [loc,val] = findPeak(result{i},1);
    val = val(loc>deadtime);
    loc = loc(loc>deadtime);
    loc1 = loc(1);
    val1 = val(1);
     [loc,val] = findNotch(result{i},1);
    val = val(loc>loc1);
    loc = loc(loc>loc1);
    loc2 = loc(1);  
    val2 = val(1);
    distanceLoc(i) = loc2 - loc1;
    distanceVal(i) = val1 - val2;
end
figure;
plot(distanceLoc);
figure;plot(distanceVal);
%% �������ļ�ʵʱ�˲�������λ�˲���ֵ�����Ա�
% ������untitile2
% Ҫ�Ƚ�ʵʱ�˲����ݴ���disLoc1��disVal1�У�����λ�˲����ݴ���disLoc2��disVal2��
figure;
h = plot([disLoc1,disLoc2],'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('ʵʱ�˲�','����λ�˲�');
set(gca,'fontsize',14);
xlabel('�����ļ����');
ylabel('��ֵ�����  (��λ�����������)');
axis('tight');
figure;
h = errorbar([disLoc1,disLoc2], [disLoc1,disLoc2] - mean([disLoc1,disLoc2]),'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('ʵʱ�˲�','����λ�˲�');
set(gca,'fontsize',14);
xlabel('�����ļ����');
ylabel('��ֵ�����ƫ��  (��λ�����������)');
axis('tight');
%% �������ļ�ʵʱ�˲�������λ�˲���ֵ�����Ա�
% Ҫ�Ƚ�ʵʱ�˲����ݴ���disLoc1��disVal1�У�����λ�˲����ݴ���disLoc2��disVal2��
figure;
h = plot([disVal1,disVal2],'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('ʵʱ�˲�','����λ�˲�');
set(gca,'fontsize',14);
xlabel('�����ļ����');
ylabel('MSD���ֵ');
axis('tight');
figure;
h = errorbar([disVal1,disVal2], [disVal1,disVal2] - mean([disVal1,disVal2]),'LineWidth',2);
h(1).Marker = 'diamond';
h(2).Marker = 'pentagram';
legend('ʵʱ�˲�','����λ�˲�');
set(gca,'fontsize',14);
xlabel('�����ļ����');
ylabel('MSD���ֵ');
axis('tight');

