%% generates the plot with different traces
% you need to run computeMatrices first

clear
close all
rng(1)

set(gca,'fontsize',10)
set(figure(1), 'Position', [0 0 370 300])

load('Data/matricesLONGsmall.mat')
for i = 1:9
    vals(i) = trace(D{i});
end
plot((0:8)/8, vals,'r--')
hold on

load('Data/matricesLONGmedium.mat')
for i = 1:16
    vals(i) = trace(D{i});
end
plot((0:15)/15, vals,'g--')

load('Data/matricesLONGlarge.mat')
for i = 1:25
    vals(i) = trace(D{i});
end
plot((0:24)/24, vals,'b--')

load('Data/matricesLONGhuge.mat')
for i = 1:36
    vals(i) = trace(D{i});
end
plot((0:35)/35, vals,'m--')

vals = [];
load('Data/matricesALSsmall.mat') 
for i = 1:9
    vals(i) = trace(D{i});
end
plot((0:8)/8, vals,'r')

load('Data/matricesALSmedium.mat')
for i = 1:16
    vals(i) = trace(D{i});
end
plot((0:15)/15, vals,'g')

load('Data/matricesALSlarge.mat') 
for i = 1:25
    vals(i) = trace(D{i});
end
plot((0:24)/24, vals,'b')

load('Data/matricesALShuge.mat') 
for i = 1:36
    vals(i) = trace(D{i});
end
plot((0:35)/35, vals,'m')

ylabel('Tr($D_s({\rho})$)','Interpreter','latex')
xlabel('${\rho}$','Interpreter','latex')
leg = legend('long-term limit N=8','long-term limit N=15','long-term limit N=24','long-term limit N=35',...
    'minimization N=8','minimization N=15','minimization N=24','minimization N=35');
set(leg,'Interpreter','latex');
print -depsc 'Figures/ComparisonToStochasticApproach.eps'

xlim([0.45,0.55])
ylim([0.65,1])
print -depsc 'Figures/ComparisonToStochasticApproachZoom.eps'



