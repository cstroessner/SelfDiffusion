clear
close all
rng(1)

%% sampling with N = 24
addpath('StochasticApproach24')
tic()
T = 300;
trace24 = zeros(25,1);
D24 = cell(25,1);
for ell = 0:24
    ell
    [QOIvec] = stochasticEstimationCombined(ell,ceil(30000/(ell+1)),T);
    d11 = QOIvec(1);
    d22 = QOIvec(2);
    d12 = 0.5*(QOIvec(3)-d11-d22);
    D24{ell+1} = [d11 d12; d12 d22];
    trace24(ell+1) = QOIvec(1)+QOIvec(2);
    toc()
end
t24 = toc();
rmpath('StochasticApproach24')

%% sampling with N = 15
addpath('StochasticApproach15')
tic()
T = 300;
trace15 = zeros(16,1);
D15 = cell(16,1);
for ell = 0:15
    ell
    [QOIvec] = stochasticEstimationCombined(ell,ceil(30000/(ell+1)),T);
    d11 = QOIvec(1);
    d22 = QOIvec(2);
    d12 = 0.5*(QOIvec(3)-d11-d22);
    D15{ell+1} = [d11 d12; d12 d22];
    trace15(ell+1) = QOIvec(1)+QOIvec(2);        
    toc()
end
t15 = toc();
rmpath('StochasticApproach15')

%% sampling with N = 8
addpath('StochasticApproach8')
tic()
T = 300;
trace8 = zeros(9,1);
D8 = cell(9,1);
for ell = 0:8
    ell
    [QOIvec] = stochasticEstimationCombined(ell,ceil(30000/(ell+1)),T);
    d11 = QOIvec(1);
    d22 = QOIvec(2);
    d12 = 0.5*(QOIvec(3)-d11-d22);
    D8{ell+1} = [d11 d12; d12 d22];
    trace8(ell+1) = QOIvec(1)+QOIvec(2);        
    toc()
end
t8 = toc();
rmpath('StochasticApproach8')

%% save
D = D24;
save('Data/matricesLONGlarge.mat','D')
D = D15;
save('Data/matricesLONGlmedium.mat','D')
D = D8;
save('Data/matricesLONGsmall.mat','D')