function Uw = findUw(D,U,p)
[~,index] = sort(abs(diag(D)),'descend');
Uw = U(:,index(p+1 : end));
end