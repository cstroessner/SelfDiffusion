% define jump vectors and probabilities
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
% returns the index i corresponding to the given vector v
% hardcoded for N = 29
v = mod(v,5);
if v(1) == 0
    if v(2) == 0
        i = 0;
    elseif v(2) == 1
        i = 7;
    elseif v(2) == 2
        i = 22;
    elseif v(2) == 3
        i = 14;
    elseif v(2) == 4
        i = 3;
    end
elseif v(1) == 1
    if v(2) == 0
        i = 5;
    elseif v(2) == 1
        i = 6;
    elseif v(2) == 2
        i = 21;
    elseif v(2) == 3
        i = 15;
    elseif v(2) == 4
        i = 4;
    end
elseif v(1) == 2
    if v(2) == 0
        i = 18;
    elseif v(2) == 1
        i = 19;
    elseif v(2) == 2
        i = 20;
    elseif v(2) == 3
        i = 16;
    elseif v(2) == 4
        i = 17;
    end
elseif v(1) == 3
    if v(2) == 0
        i = 10;
    elseif v(2) == 1
        i = 9;
    elseif v(2) == 2
        i = 24;
    elseif v(2) == 3
        i = 12;
    elseif v(2) == 4
        i = 11;
    end
else
    if v(2) == 0
        i = 1;
    elseif v(2) == 1
        i = 8;
    elseif v(2) == 2
        i = 23;
    elseif v(2) == 3
        i = 13;
    elseif v(2) == 4
        i = 2;
    end
end
end

