function Us = findUs(D,U,p)
[~,index] = sort(abs(diag(D)),'descend');
Us = U(:,index(1:p));
end