function [d,N,K,v,p,vectors,tau] = initialization()
% initializes everything for our standard model

d = 2; % dimension
N = 24; % number of grid points without the central one (i.e. N=8,24,48,...)
K = 4; % number of jumps

% jump directions
v{1} = [1,0];
v{2} = [-1,0];
v{3} = [0,1];
v{4} = [0,-1];

% jump probabilities (need to sum up to 1)
p(1) = 0.25;
p(2) = 0.25;
p(3) = 0.25;
p(4) = 0.25;

% base vectors (need to correspond to vecIndex)
vectors{1} = [-1,0];
vectors{2} = [-1,-1];
vectors{3} = [0,-1];
vectors{4} = [1,-1];
vectors{5} = [1,0];
vectors{6} = [1,1];
vectors{7} = [0,1];
vectors{8} = [-1,1];
vectors{9} = [-2,1];
vectors{10} = [-2,-0];
vectors{11} = [-2,-1];
vectors{12} = [-2,-2];
vectors{13} = [-1,-2];
vectors{14} = [0,-2];
vectors{15} = [1,-2];
vectors{16} = [2,-2];
vectors{17} = [2,-1];
vectors{18} = [2,0];
vectors{19} = [2,1];
vectors{20} = [2,2];
vectors{21} = [1,2];
vectors{22} = [0,2];
vectors{23} = [-1,2];
vectors{24} = [-2,2];
vectors{25} = [0,0];

% obtin index mapping for moving from particle i in the direction of v k
tau = getTau(vectors,v,N);
end

