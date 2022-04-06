%% reproduces the figure on the parameters for sampling with the stochatic algorithm 

clear
close all
rng(1)

%initialize
addpath('StochasticApproach24')
u = [1,0];
T = 10000;
samples = 10000;

% run longer
valsLonger = cell(10,1);
parfor run = 1:12
valLonger = zeros(T/10,1);
for ell = 0
    [QOI, qoi, qoisTimes] = stochasticEstimation(u,ell,samples,T);
    valLonger(:) = 1/samples.*sum(qoisTimes,1)./(10:10:T);
end
valsLonger{run} = valLonger;
end

% more samples
T = 1000;
samples = 100000;
valsMore = cell(10,1);
parfor run = 1:12
valMore = zeros(T/10,1);
for ell = 0
    [QOI, qoi, qoisTimes] = stochasticEstimation(u,ell,samples,T);
    valMore(:) = 1/samples.*sum(qoisTimes,1)./(10:10:T);
end
valsMore{run} = valMore;
end
rmpath('StochasticApproach24')

%% plot
set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])
for run = 1:12
    plot(10:10:10000,valsLonger{run})
    hold on
end
xlabel('time','Interpreter','latex')
ylabel('$\mathbf u^T \mathbf D_s(0) \mathbf u$','Interpreter','latex')
print -depsc 'Figures/TimeLongerRun.eps'

set(gca,'fontsize',10)
set(figure(2), 'Position', [0 0 370 300])
for run = 1:12
    plot(10:10:1000,valsMore{run})
    hold on
end
xlabel('time','Interpreter','latex')
ylabel('$\mathbf u^T \mathbf D_s(0) \mathbf u$','Interpreter','latex')
print -depsc 'Figures/TimeMoreSamples.eps'

%save
save('Data/timeEll1.mat')
