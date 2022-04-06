function i = vecIndex(v)
v = mod(v,4);
if v(1) > 0 || v(2) > 0
    i = sub2ind([4,4],v(1)+1,v(2)+1)-1;
else
   i = 16; 
end
end