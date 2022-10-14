clear
close all
rng(1)

load ('Data/samplingStochastic.mat')
set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])
loglog(effectiveJumps(1,:)*timeRun/effectiveJumps(1,end),stdy.^2,'m')
hold on

clear 
load('Data/FigureMonteCarloStudy.mat') 
loglog(samplesData(1,:)*estimTimePerEval,stdyNaive.^2,'r')
hold on
loglog(samplesData(1,:)*estimTimePerEval,stdyImproved.^2,'b')

xlabel('time in seconds','Interpreter','latex')
ylabel('variance of $\frac{2}{N+1}\sum_{\ell = 0}^N \mathbf{u}^T \mathbf{D}_s (\frac{\ell}{N}) \mathbf{u}$','Interpreter','latex')
leg = legend('long-term limit', 'naive Monte Carlo', 'with variance reduction');
set(leg,'Interpreter','latex','Location','northeast');
xlim([2,2500])

print -depsc 'Figures/VarianceRuntime.eps'

%%
clear
close all
rng(1)

load ('Data/samplingStochastic.mat')
set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])
loglog(effectiveJumps(1,:)*timeRun/effectiveJumps(1,end),stdy.^2,'m')
hold on

clear 
load('Data/FigureMonteCarloStudy.mat') 
loglog(samplesData(1,:)*estimTimePerEval+solutionTime,stdyNaive.^2,'r')
hold on
loglog(samplesData(1,:)*estimTimePerEval+solutionTime,stdyImproved.^2,'b')

xlabel('time in seconds','Interpreter','latex')
ylabel('variance of $\frac{2}{N+1}\sum_{\ell = 0}^N \mathbf{u}^T \mathbf{D}_s (\frac{\ell}{N}) \mathbf{u}$','Interpreter','latex')
leg = legend('long-term limit', 'naive Monte Carlo', 'with variance reduction');
set(leg,'Interpreter','latex','Location','northeast');
xlim([2,2500])

print -depsc 'Figures/VarianceRuntimeWithSolutionTime.eps'