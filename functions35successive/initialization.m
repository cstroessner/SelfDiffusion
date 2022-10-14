function [d,N,K,v,p,vectors,tau] = initialization()
% initializes everything for our standard model

d = 2; % dimension
N = 35; % number of grid points without the central one (i.e. N=8,24,48,...)
K = 6; % number of jumps

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
vectors{N+1} = [0,0]; 
for i = 1:N
   [I,J] = ind2sub([sqrt(N+1),sqrt(N+1)],i+1);
   vectors{i} = [I,J]-[1,1];
end

% obtin index mapping for moving from particle i in the direction of v k
tau = getTau(vectors,v,N);
end

