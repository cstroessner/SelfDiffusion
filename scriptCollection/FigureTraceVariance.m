clear
close all
rng(1)

%% generate data
tic()
computeTraceVarianceForN8
t8 = toc()
tic()
computeTraceVarianceForN15
t15 = toc()
tic()
computeTraceVarianceForN24
t24 = toc()

%% plot for N=8
clear 
close all
load('Data/traceVariance8.mat')

N = 8;
runs = 100;

set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 300 300])
hold on

for run = 1:runs
plot((0:N)/N,tracesLongTerm(run,:),'m:')
plot((0:N)/N,tracesALS(run,:),'b:')
end
ylabel('Tr($D_s({\rho})$)','Interpreter','latex')
xlabel('$\rho$','Interpreter','latex')

for iter = 1:N+1
     y = tracesLongTerm(:,iter);
     ym(iter) = mean(y);
     stdy(iter) = std(y);                                                                     
end
greyArea1 = patch([(0:N)/N fliplr((0:N)/N)], [ym-stdy fliplr(ym+stdy)], 'r');
greyArea1.FaceAlpha = 0.4;

for iter = 1:N+1
     y = tracesALS(:,iter);
     ym(iter) = mean(y);
     stdy(iter) = std(y);                                                                     
end
greyArea1 = patch([(0:N)/N fliplr((0:N)/N)], [ym-stdy fliplr(ym+stdy)], 'c');
greyArea1.FaceAlpha = 0.4;

leg = legend('long-term limit N=8','minimization N=8');
set(leg,'Interpreter','latex');

xlim([0.47,0.53])
ylim([0.68,0.87])

print -depsc 'Figures/TraceVariancePlotZoom8.eps'

%% plot for N=15
clear 
close all
load('Data/traceVariance15.mat')

N = 15;
runs = 100;

set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 300 300])
hold on

for run = 1:runs
plot((0:N)/N,tracesLongTerm(run,:),'m:')
plot((0:N)/N,tracesALS(run,:),'b:')
end
ylabel('Tr($D_s({\rho})$)','Interpreter','latex')
xlabel('$\rho$','Interpreter','latex')

for iter = 1:N+1
     y = tracesLongTerm(:,iter);
     ym(iter) = mean(y);
     stdy(iter) = std(y);                                                                     
end
greyArea1 = patch([(0:N)/N fliplr((0:N)/N)], [ym-stdy fliplr(ym+stdy)], 'r');
greyArea1.FaceAlpha = 0.4;

for iter = 1:N+1
     y = tracesALS(:,iter);
     ym(iter) = mean(y);
     stdy(iter) = std(y);                                                                     
end
greyArea1 = patch([(0:N)/N fliplr((0:N)/N)], [ym-stdy fliplr(ym+stdy)], 'c');
greyArea1.FaceAlpha = 0.4;

leg = legend('long-term limit N=15','minimization N=15');
set(leg,'Interpreter','latex');

xlim([0.47,0.53])
ylim([0.68,0.87])

print -depsc 'Figures/TraceVariancePlotZoom15.eps'

%% plot for N=24
clear 
close all
load('Data/traceVariance24.mat')

N = 24;
runs = 100;

set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 300 300])
hold on

for run = 1:runs
plot((0:N)/N,tracesLongTerm(run,:),'m:')
plot((0:N)/N,tracesALS(run,:),'b:')
end
ylabel('Tr($D_s({\rho})$)','Interpreter','latex')
xlabel('$\rho$','Interpreter','latex')

for iter = 1:N+1
     y = tracesLongTerm(:,iter);
     ym(iter) = mean(y);
     stdy(iter) = std(y);                                                                     
end
greyArea1 = patch([(0:N)/N fliplr((0:N)/N)], [ym-stdy fliplr(ym+stdy)], 'r');
greyArea1.FaceAlpha = 0.4;

for iter = 1:N+1
     y = tracesALS(:,iter);
     ym(iter) = mean(y);
     stdy(iter) = std(y);                                                                     
end
greyArea1 = patch([(0:N)/N fliplr((0:N)/N)], [ym-stdy fliplr(ym+stdy)], 'c');
greyArea1.FaceAlpha = 0.4;


leg = legend('long-term limit N=24','minimization N=24');
set(leg,'Interpreter','latex');

xlim([0.47,0.53])
ylim([0.68,0.87])

print -depsc 'Figures/TraceVariancePlotZoom24.eps'


%% generate data for the table
clear 
close all
load('Data/traceVariance24.mat')
N=24;

for iter = 1:N+1
     y = tracesLongTerm(:,iter);
     var(iter) = std(y).^2;                                                                     
end
fprintf('N=%2.0f long-term    mean %.3e max %.3e \n',N,mean(var),max(var))

for iter = 1:N+1
     y = tracesALS(:,iter);
     var(iter) = std(y).^2;                                                                     
end
fprintf('N=%2.0f minimization mean %.3e max %.3e \n',N,mean(var),max(var))

clear 
close all
load('Data/traceVariance15.mat')
N=15;

for iter = 1:N+1
     y = tracesLongTerm(:,iter);
     var(iter) = std(y).^2;                                                                     
end
fprintf('N=%2.0f long-term    mean %.3e max %.3e \n',N,mean(var),max(var))

for iter = 1:N+1
     y = tracesALS(:,iter);
     var(iter) = std(y).^2;                                                                     
end
fprintf('N=%2.0f minimization mean %.3e max %.3e \n',N,mean(var),max(var))

clear 
close all
load('Data/traceVariance8.mat')
N=8;

for iter = 1:N+1
     y = tracesLongTerm(:,iter);
     var(iter) = std(y).^2;                                                                     
end
fprintf('N=%2.0f long-term    mean %.3e max %.3e \n',N,mean(var),max(var))

for iter = 1:N+1
     y = tracesALS(:,iter);
     var(iter) = std(y).^2;                                                                     
end
fprintf('N=%2.0f minimization mean %.3e max %.3e \n',N,mean(var),max(var))

