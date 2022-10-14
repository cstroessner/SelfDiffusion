function i = vecIndex(v)
N = 6;
v = mod(v,N);
if v(1) > 0 || v(2) > 0
    i = sub2ind([N,N],v(1)+1,v(2)+1)-1;
else
   i = N*N; 
end
end