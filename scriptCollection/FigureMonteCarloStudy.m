%% generates the plot on the Monte Carlo error and the impact of the variance reduction

clear
close all
addpath('functions24successive')
rng(1)

% initialize
[d,N,K,v,p,vectors,tau] = initialization();
u = [1,0]; psiDatas = {}; R = 3;

% compute accurate rank-3 approximation
tic()
for r = 1:R
psiDatas{r} = rand([N,2]);
psiDatas = ALSsuc(u,psiDatas,v,p,tau,N,1e-12,420);
end
solutionTime = toc()
psi = @(eta) PsiSuc(eta,psiDatas);

% estimate the trace (exploit symmetry in hopping model: D_11 = D_22)
totalRuns = 250;
sampleSteps = 150;
samplesData = zeros(totalRuns,sampleSteps);
trImprovedData = zeros(totalRuns,sampleSteps);
trNaiveData = zeros(totalRuns,sampleSteps);

parfor run = 1:totalRuns
    run
    [trImproved,trNaive,samples] = executeRun(u,psi,v,p,tau,N,sampleSteps); 
    samplesData(run,:) = samples;
    trImprovedData(run,:) = trImproved;
    trNaiveData(run,:) = trNaive;    
end

% plot results
close all
figure(1)
set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])
for run = 1:totalRuns
semilogx(samplesData(1,:),trNaiveData(run,:)/(N+1),'r:')
hold on
semilogx(samplesData(1,:),trImprovedData(run,:)/(N+1),'b:')
end
ylabel('$$\frac{2}{N+1}\sum_{\ell = 0}^N \mathbf u^T \mathbf D_s (\frac{\ell}{N}) \mathbf u$$','Interpreter','latex')
xlabel('number of evaluations','Interpreter','latex')
for iter = 1:sampleSteps
    y = trNaiveData(:,iter)/(N+1);
    ymNaive(iter) = mean(y);
    stdyNaive(iter) = std(y)                                                % Standard Deviation
    y = trImprovedData(:,iter)/(N+1);
    ymImproved(iter) = mean(y);
    stdyImproved(iter) = std(y)                                              
end
hold on 
greyArea1 = patch([samplesData(1,:) fliplr(samplesData(1,:))], [ymNaive-stdyNaive fliplr(ymNaive+stdyNaive)], 'r');
greyArea1.FaceAlpha = 0.4;
greyArea2 = patch([samplesData(1,:) fliplr(samplesData(1,:))], [ymImproved-stdyImproved fliplr(ymImproved+stdyImproved)], 'b');
greyArea2.FaceAlpha = 0.4;
leg = legend('naive Monte Carlo','with variance reduction')
set(leg,'Interpreter','latex');
ylim([0.8,0.88])
xlim([samplesData(1,1),samplesData(1,end)])
print -depsc 'Figures/SamplingWithStandardDeviation.eps'

figure(2)
set(gca,'fontsize',10)
set(figure(2), 'Position', [0 0 370 300])
loglog(samplesData(1,:),stdyNaive.^2,'r')
hold on
loglog(samplesData(1,:),stdyImproved.^2,'b')
xlabel('number of evaluations','Interpreter','latex')
ylabel('variance','Interpreter','latex')
leg = legend('naive Monte Carlo','with variance reduction')
set(leg,'Interpreter','latex');
ylim([1e-7,1e-1])
xlim([samplesData(1,1),samplesData(1,end)])
print -depsc 'Figures/DecayOfStandardDeviation.eps'

% compute mean time to evaluate for a given eta
for iter = 1:4000
eta = round(rand(24,1));
tic();
evalAuForEta(u,psi,eta,v,p,tau);
t(iter) = toc();
end
estimTimePerEval = mean(t)

% measure time for one run (excluding solving the optimization problem)
tic()
for l = 0:N % we need to compute each ell separately
    evalAluSamplingSuc(u,psi,l,v,p,tau,N,10*sampleSteps);
end
timeRun = toc()

save('Data/FigureMonteCarloStudy.mat') 
rmpath('functions24successive')

% function for parallel evaluation
function [trImproved,trNaive,samples] = executeRun(u,psi,v,p,tau,N,sampleSteps) 
stepsize = 10; trsImproved = zeros(sampleSteps,N+1); trsNaive = zeros(sampleSteps,N+1); samplesData = zeros(sampleSteps,N+1);
trImproved = zeros(sampleSteps,1); trNaive = zeros(sampleSteps,1); samples = zeros(sampleSteps,1);
    for i = stepsize:stepsize:sampleSteps*stepsize 
        for l = 0:N
            [totalVal,totalSamples] = evalAluSamplingSuc(u,psi,l,v,p,tau,N,stepsize);
            trsImproved(i/stepsize,l+1) = totalVal;
            trsNaive(i/stepsize,l+1) = evalAluSamplingSucNaive(u,psi,l,v,p,tau,N,totalSamples); 
            samplesData(i/stepsize,l+1) = totalSamples;
        end
    trImproved(i/stepsize) = 2*2/i*stepsize*sum(trsImproved(:,:),'all');
    trNaive(i/stepsize) = 2*2/i*stepsize*sum(trsNaive(:,:),'all');
    samples(i/stepsize) = sum(samplesData(:,:),'all');  
    end
end






