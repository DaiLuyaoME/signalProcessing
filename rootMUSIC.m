function theta_es = rootMUSIC(x,p,d)
%求自相关矩阵
[m,sample_num] = size(x);
Rx = 1 / sample_num *( x * x');
[U D] = eig(Rx);
%获得噪声子空间
Uw = U(:,m-p:-1:1);
temp = Uw * Uw';
pw = zeros(1,m);
for i = m:-1:1
    if i > m / 2
        pw(m-i+1)=sum(diag(temp(i:end,1:m-i+1)))  ;
    else
        pw(m-i+1)=sum(diag(temp(1:m-i+1,i:end)))  ;
    end
end
r = roots(pw);
dis = real(r) .^ 2 + imag(r) .^ 2 ;
[~,I]=sort(dis);
omega_es = r(I(1:p));
temp = (atan(imag(omega_es)./real(omega_es))); 
loc = find(real(omega_es)<0);
temp(loc) = temp(loc) + pi * sign(imag(omega_es(loc)));
omega_es = temp;   
theta_es = asin(omega_es / (2 * d * pi)) / pi * 180;
theta_es = sort(theta_es');

% omega_es = r(I(1:end));
% omega_es = sign(imag(omega_es)) .* atan(imag(omega_es)./real(omega_es)); 
% theta_es = asin(omega_es / (2 * d * pi)) / pi * 180;
% t = 2;
% while abs(theta_es(2) -  theta_es(1) ) < 1
%     if t >= length(r) 
%         break;
%     end
%     t = t + 1;
%     theta_es(2) = theta_es(t);
% end
% 
% while (abs(theta_es(3) -  theta_es(2) ) < 1 )|| (abs(theta_es(3) -  theta_es(1) )) < 1
%     if t >= length(r) 
%         break;
%     end
%     t = t + 1;
%     theta_es(3) = theta_es(t);
% end
% theta_es = theta_es(1:p)';
% theta_es = sort(theta_es);
