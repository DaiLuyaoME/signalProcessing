f = [0.1,0.2,0.3]; %�ź�Ƶ��
Am = [1,2,5];%�źŷ�ֵ
m = 20;%������Ŀ
p = 3; %�ź���Ŀ
d = 0.5;% d/lambda 
theta = [-30,0,30]; % ��ʵ��λ��
omega = 2 * pi * d * sin(theta/180*pi);% ��ʵ��λ��
maxiter = 10000;%�ظ��������
SNR_dB = 0:1:20;
SNR = power(10,SNR_dB/10);
MSE_rootM_seq = zeros(1,length(SNR_dB));
sample_num = 50;
N = 1:maxiter;
%��A����
temp = 0:1:(m-1);
temp = temp' * omega;
A = exp(1i * temp);
for i = 1:length(SNR_dB)
    snr = SNR(i);
    MSE_rootM = 0;
    for iter = 1:maxiter%�ظ�������MSE
        n = 1:sample_num;
        s = repmat(Am',1,sample_num) .* sin(2 * pi * f' * n );
        x = sqrt(snr)* A  * s  + randn(m,sample_num);
        %% rootMUSIC����
        theta_es_rootM = rootMUSIC(x,p,d);
        MSE_rootM = MSE_rootM + sum((theta_es_rootM-theta).^2)/3;
    %     %������ؾ���
    %     Rx = 1 / sample_num *( x * x');
    %     [U D] = eig(Rx);
    %     %��������ӿռ�
    %     Uw = U(:,m-p:-1:1);
    %     temp = Uw * Uw';
    %     pw = zeros(1,m);
    %     for i = m:-1:1
    %         if i > m / 2
    %             pw(m-i+1)=sum(diag(temp(i:end,1:m-i+1)))  ;
    %         else
    %             pw(m-i+1)=sum(diag(temp(1:m-i+1,i:end)))  ;
    %         end
    %     end
    %     r = roots(pw);
    %     dis = real(r) .^ 2 + imag(r) .^ 2 ;
    %     [~,I]=sort(dis);
    %     omega_es = r(I(1:p));
    %     omega_es = atan(imag(omega_es)./real(omega_es)); 
    %     theta_es = asin(omega_es / pi) / pi * 180;
    end
    MSE_rootM_seq(i) = 1/maxiter * MSE_rootM;
end
