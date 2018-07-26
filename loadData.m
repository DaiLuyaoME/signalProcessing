clear;
%%
dataSetName = 'dataSet2/';
nameList = dir(['./data/',dataSetName,'*.csv']);
pathName = [nameList(1).folder,'/'];
% fileName = nameList.name;
powerDataIndex = 1;
rowOffset = 2;
colOffset = 1;
mode = 2; % 1 for matrix; 2 for cell
minNum = 2940;
switch mode
    case 1
        data = [];
        for i = 1 : numel(nameList)
            tempData = csvread([pathName,nameList(i).name],rowOffset,colOffset);
            tempData = tempData(1:minNum,:);
            data = [data,tempData(:,powerDataIndex)];
        end
        
    case 2
        data = {};
        for i = 1 : numel(nameList)
            tempData = csvread([pathName,nameList(i).name],rowOffset,colOffset);
            data = [data,tempData(:,powerDataIndex)];
        end
end
%%

