%% reproduces the figure on the variance in the purely stochastic algorithm

clear
close all
rng(1)

% parameters
T = 300;
runs = 50;
effectiveJumps = 100:100:30000; %where do we want to plot

% sampling with N = 24
addpath('StochasticApproach24')
u = [1,0];
traces = zeros(runs,numel(effectiveJumps));
tracesList = cell(numel(effectiveJumps),1);
qoiBigList = cell(numel(effectiveJumps),1);
qoiTimesBigList = cell(numel(effectiveJumps),1);
parfor run = 1:runs
    tracesList{run} = zeros(numel(effectiveJumps),1);
    qoiBigList{run} = zeros(25,1)
    qoiList = cell(25);
    qoiListTimes = cell(25,1)
    for ell = 0:24
        [QOI,qois] = stochasticEstimation(u,ell,ceil(effectiveJumps(end)/(ell+1)),T);
        qoiList{ell+1} = qois;
    end
    for ell = 0:24
        for i = 1:numel(effectiveJumps)
            tracesList{run}(i) = tracesList{run}(i) + 2/ceil(effectiveJumps(i)/(ell+1))*sum(qoiList{ell+1}(1:ceil(effectiveJumps(i)/(ell+1))))/T; %2 to account for both entries exploiting symmetry
        end
    end
    qoiBigList{run} = {qoiList};
end

%% plot results
for run = 1:runs
    for i = 1:numel(effectiveJumps)
        traces(run,i) = tracesList{run}(i);
    end
end
close all
figure(1)
set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])
for run = 1:runs
semilogx(effectiveJumps,traces(run,:)/(24+1),'m:')
hold on
end
ylabel('$$\frac{2}{N+1}\sum_{\ell = 0}^N \mathbf{u}^T \mathbf{D}_s (\frac{\ell}{N}) \mathbf{u} $$','Interpreter','latex')
xlabel('$\hat{N}_s$','Interpreter','latex')
for iter = 1:numel(effectiveJumps)
    y = traces(:,iter)/(24+1);
    ym(iter) = mean(y);
    stdy(iter) = std(y);                                                                     
end
hold on 
greyArea1 = patch([effectiveJumps fliplr(effectiveJumps)], [ym-stdy fliplr(ym+stdy)], 'm');
greyArea1.FaceAlpha = 0.4;
xlim([min(effectiveJumps),max(effectiveJumps)])
ylim([0.8,0.88])
print -depsc 'Figures/SamplingStochasticWithStandardDeviation.eps'

% plot 2
figure(2)
set(gca,'fontsize',10)
set(figure(2), 'Position', [0 0 370 300])
loglog(effectiveJumps(1,:),stdy.^2,'m')
hold on
xlabel('$\hat{N}_s$','Interpreter','latex')
ylabel('variance','Interpreter','latex')
for ell = 1:25
    B = [];
    for run = 1:runs
        A = qoiBigList{run}{1};
        A = A{ell,1};
        for i = 1:numel(effectiveJumps)
            C(i,run) = sum(A(1:ceil(effectiveJumps(i)/(ell))))/ceil(effectiveJumps(i)/(ell))/T;
        end
    end
    for i = 1:numel(effectiveJumps)
        stdC(i) = std(C(i,:));
    end
    loglog(effectiveJumps(1,:),stdC.^2,':k')
    hold on
end
leg = legend('$\frac{2}{N+1}\sum_{\ell = 0}^N \mathbf{u}^T \mathbf{D}_s (\frac{\ell}{N}) \mathbf{u}$', '$\mathbf{u}^T \mathbf{D}_s (\frac{\ell}{N}) \mathbf{u}$ for $\ell=0,\dots,24$');
set(leg,'Interpreter','latex','Location','southwest');
xlim([min(effectiveJumps),max(effectiveJumps)])
ylim([1e-7,1e-1])
print -depsc 'Figures/StochasticDecayOfStandardDeviation.eps'

%% measure time for one trace computation with max number of effectiveJumps
tic()
for ell = 0:24
        [QOI,qois] = stochasticEstimation(u,ell,ceil(effectiveJumps(end)/(ell+1)),T);
end
timeRun = toc()
datestr(now)

% save
save('Data/samplingStochastic.mat')

