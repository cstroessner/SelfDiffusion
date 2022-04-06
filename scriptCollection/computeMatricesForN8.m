clear
close all
addpath('functions8successive')
rng(1)
tic()

% evaluate 
vals01 = getVals([0,1]);
vals10 = getVals([1,0]);
vals11 = getVals([1,1]);

% build matrix
for l = 0:8
   d11 = vals10(l+1); 
   d22 = vals01(l+1);
   d12 = 0.5*(vals11(l+1)-d11-d22);
   D{l+1} = 2*[d11 d12; d12 d22];
end
toc()
save('Data/matricesALSsmall.mat','D');
rmpath('functions8successive')

function vals = getVals(u)
[~,N,~,v,p,~,tau] = initialization(); psiDatas = {}; 
R = 3; 
% optimize
for r = 1:R
psiDatas{r} = rand([N,2]);
psiDatas = ALSsuc(u,psiDatas,v,p,tau,N,1e-12,420);
end
% evaluate by sampling
psi = @(eta) PsiSuc(eta,psiDatas);
for l = 0:N
    [val] = evalAluNaive(u,psi,l,v,p,tau,N);
    vals(l+1) = val;
end
end