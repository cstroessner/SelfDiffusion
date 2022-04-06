load('matricesALSlarge.mat')
M = zeros(26,4);
for k = 2:26
    M(k,:) = D{k-1}(:);
end
dlmwrite('matrices.csv',M,'delimiter',',','precision',20)