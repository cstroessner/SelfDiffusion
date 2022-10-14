% define jump vectors and probabilities
d = 2; % dimension
N = 35; % number of grid points without the central one (i.e. N=8,24,48,...)
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
vectors{N+1} = [0,0]; 
for i = 1:N
   [I,J] = ind2sub([sqrt(N+1),sqrt(N+1)],i+1);
   vectors{i} = [I,J]-[1,1];
end

% obtin index mapping for moving from particle i in the direction of v k
tau = getTau(vectors,v,N);


function tau = getTau(vectors,v,N)
%tau(k,i) returns the index of the location obtained by moving from
%position i in the direction of v_k
for i = 1:N+1
    t1(i) = vecIndex(vectors{i}+v{1});
    t2(i) = vecIndex(vectors{i}+v{2});
    t3(i) = vecIndex(vectors{i}+v{3});
    t4(i) = vecIndex(vectors{i}+v{4});
end
tau = @(k,i) taufun(k,i,t1,t2,t3,t4,N);
end

function i = taufun(k,i,t1,t2,t3,t4,N)
i = mod(i,N+1);
if i == 0
    i = N+1;
end
if k == 1
    i = mod(t1(i),N+1);
elseif k == 2
    i = mod(t2(i),N+1);
elseif k == 3
    i = mod(t3(i),N+1);
else %k == 4
    i = mod(t4(i),N+1);
end
end

function i = vecIndex(v)
N = 6;
v = mod(v,N);
if v(1) > 0 || v(2) > 0
    i = sub2ind([N,N],v(1)+1,v(2)+1)-1;
else
   i = N*N; 
end
end

