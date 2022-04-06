function tau = getTau(vectors,v)
%tau(k,i) returns the index of the location obtained by moving from
%position i in the direction of v_k
for i = 1:9
    t1(i) = vecIndex(vectors{i}+v{1});
    t2(i) = vecIndex(vectors{i}+v{2});
    t3(i) = vecIndex(vectors{i}+v{3});
    t4(i) = vecIndex(vectors{i}+v{4});
end
tau = @(k,i) taufun(k,i,t1,t2,t3,t4);
end


function i = taufun(k,i,t1,t2,t3,t4)
i = mod(i,9);
if i == 0
    i = 9;
end
if k == 1
    i = mod(t1(i),9);
elseif k == 2
    i = mod(t2(i),9);
    
elseif k == 3
    i = mod(t3(i),9);
else %k == 4
    i = mod(t4(i),9);
end
end