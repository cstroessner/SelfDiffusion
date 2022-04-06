clear
close all
addpath('functions24successive')
rng(1)
tic()

% evaluate 
vals01 = getVals([0,1]);
vals10 = getVals([1,0]);
vals11 = getVals([1,1]);

% build matrix
for l = 0:24
   d11 = vals10(l+1); 
   d22 = vals01(l+1);
   d12 = 0.5*(vals11(l+1)-d11-d22);
   D{l+1} = 2*[d11 d12; d12 d22];
end
toc()
save('Data/matricesALSlarge.mat','D');
rmpath('functions24successive')

function vals = getVals(u)
[~,N,~,v,p,~,tau] = initialization(); psiDatas = {}; 
R = 3; samples = 50;
% optimize
for r = 1:R
psiDatas{r} = rand([N,2]);
psiDatas = ALSsuc(u,psiDatas,v,p,tau,N,1e-12,420);
end
% evaluate by sampling
psi = @(eta) PsiSuc(eta,psiDatas);
for l = 0:N
    [val] = evalAluSamplingSuc(u,psi,l,v,p,tau,N,samples);
    vals(l+1) = val;
end
end








