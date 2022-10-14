clear
close all

runs = 100;

%% new ALS approach
addpath('functions8successive')
parfor run = 1:runs
    % evaluate entries
    vals01 = getVals([0,1]);
    vals10 = getVals([1,0]);
    tracesALSrun = zeros(9,1);
    % get trace
    for l = 0:8
        d11 = vals10(l+1);
        d22 = vals01(l+1);
        tracesALSrun(l+1) = 2*(d11+d22);
    end
    tracesALS(run,:) = tracesALSrun;
end
rmpath('functions8successive')

%% sampling long term limit
addpath('StochasticApproach8')
parfor run = 1:runs
    % run long term estimation
    T = 300;
    tracesLongTermRun = zeros(9,1);
    for ell = 0:8
        [QOIvec] = stochasticEstimationCombined(ell,ceil(30000/(ell+1)),T);
        tracesLongTermRun(ell+1) = QOIvec(1)+QOIvec(2);
    end
    tracesLongTerm(run,:) = tracesLongTermRun;
end
rmpath('StochasticApproach8')

save('Data/traceVariance8.mat','tracesALS','tracesLongTerm');


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