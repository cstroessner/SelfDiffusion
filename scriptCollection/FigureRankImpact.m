%% generates the plot on the impact of the rank

%% M = 2
clear
close all
addpath('functions24successive')
rng(1)
% initialize
[d,N,K,v,p,vectors,tau] = initialization();
u = [1,0];
% get 12 runs up to rank 10
R = 10; 
vals = zeros(10,R);
parfor runs  = 1:12
    tic()
    psiDatas = cell(1);
    for r = 1:R
        psiDatas{r} = rand([N,2]);
        psiDatas = ALSsuc(u,psiDatas,v,p,tau,N,10.^(-12),420);
        vals(runs,r) = evalAuTTsuc(u,psiDatas,v,p,tau);
    end
    t24Run = toc()
end
% plot
figure(1)
set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])
for runs = 1:12
   semilogy(1:R,abs(vals(runs,:)-vals(runs,end))./vals(runs,end))
   hold on 
end
ylabel('$|A^u_2(\Phi^r) - A^u_2(\Phi^{10})|/|A^u_2(\Phi^{10})|$','Interpreter','latex')
xlabel('rank-$r$','Interpreter','latex')
ylim([1e-4,3e-2])
xlim([1,9])
print -depsc 'Figures/AuVsRankSeveralRuns.eps'
% meassure time
tic()
psiDatas = cell(1);
for r = 1:R
    psiDatas{r} = rand([N,2]);
    psiDatas = ALSsuc(u,psiDatas,v,p,tau,N,10.^(-12),420);
end
t24Run = toc()
%save
save('Data/FigureRankImpact24','vals')

%% M = 1
clear
close all
rmpath('functions24successive')
addpath('functions8successive')
rng(1)
% initialize
[d,N,K,v,p,vectors,tau] = initialization();
u = [1,0];
% get 12 runs up to rank 10
R = 10;
vals = zeros(10,R);
parfor runs  = 1:12
    psiDatas = cell(1);
    for r = 1:R
        psiDatas{r} = rand([N,2]);
        psiDatas = ALSsuc(u,psiDatas,v,p,tau,N,10.^(-12),420);
        vals(runs,r) = evalAuTTsuc(u,psiDatas,v,p,tau);
    end
end
% plot
figure(1)
set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])
for runs = 1:12
   semilogy(1:R,abs(vals(runs,:)-vals(runs,end))./vals(runs,end))
   hold on 
end
ylabel('$|A^u_1(\Phi^r) - A^u_1(\Phi^{10})|/|A^u_1(\Phi^{10})|$','Interpreter','latex')
xlabel('rank-$r$','Interpreter','latex')
ylim([1e-4,3e-2])
xlim([1,9])
print -depsc 'Figures/AuVsRankSeveralRunsM1.eps'
% meassure time
tic()
psiDatas = cell(1);
for r = 1:R
    psiDatas{r} = rand([N,2]);
    psiDatas = ALSsuc(u,psiDatas,v,p,tau,N,10.^(-12),420);
end
t8Run = toc()
%save
save('Data/FigureRankImpact8','vals')




