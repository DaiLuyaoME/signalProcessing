function [pxx,w] = classicMUSIC(data,p,nFFT)

% method = 'modified'; % ע����غ����Ĺ��Ʒ�����ѡȡ�Խ���кܴ��Ӱ�죻
method = 'autocorrelation';
m = numel(data);
[~,R] = corrmtx(data,m-1,method); % ������غ�������
% R = data * data';
[V,D] = eig(R);
% Uw = V(:,1:end - (p-1)); % �����ӿռ�
Uw = findUw(D,V,p);

%%
% temp = fft(Uw);
% for i = 1:m
%     P(i) = norm(temp(i,:)).^2;
% end
% 
% index = (0:m-1)/m * 2 * pi;
% figure; plot(index,20 * log10(1./P));
% grid on;
%%
w = linspace(0,2*pi,nFFT);
num = numel(w);
tempP = zeros(num,1);
for i = 1:num
    tempW = w(i);
    temp = zeros(1,m);temp(1) = exp(tempW * 1j);a = transpose ( fliplr ( vander(temp) ) ); a = a(:,1);
    tempP(i) = norm(a' * Uw).^2;
end
pxx = 1./tempP;




end