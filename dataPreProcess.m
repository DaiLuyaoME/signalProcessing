function dataProcessed = dataPreProcess(data,pos1,pos2,k1)
if nargin == 3
    k1 = 17;
end
e0 = 190;
e_cup=630;
L=530;
k2=55;   
% k1=17;   
p_ave = data;
%数据处理

e1=e_cup-pos1;
e2=2*L*sin((60-pos2)/360*pi);
dataProcessed=(p_ave-k1*e2/175-k2)./e1*e0;   %归一化
end
