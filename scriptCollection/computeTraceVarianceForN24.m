clear
close all

runs = 100;

%% new ALS approach
addpath('functions24successive')
parfor run = 1:runs
    % evaluate entries
    vals01 = getVals([0,1]);
    vals10 = getVals([1,0]);
    tracesALSrun = zeros(25,1);
    % get trace
    for l = 0:24
        d11 = vals10(l+1);
        d22 = vals01(l+1);
        tracesALSrun(l+1) = 2*(d11+d22);
    end
    tracesALS(run,:) = tracesALSrun;
end
rmpath('functions24successive')

%% sampling long term limit
addpath('StochasticApproach24')
parfor run = 1:runs
    % run long term estimation
    T = 300;
    tracesLongTermRun = zeros(25,1);
    for ell = 0:24
        [QOIvec] = stochasticEstimationCombined(ell,ceil(30000/(ell+1)),T);
        tracesLongTermRun(ell+1) = QOIvec(1)+QOIvec(2);
    end
    tracesLongTerm(run,:) = tracesLongTermRun;
end
rmpath('StochasticApproach24')

save('Data/traceVariance24.mat','tracesALS','tracesLongTerm');


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