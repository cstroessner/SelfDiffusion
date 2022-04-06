function i = vecIndex(v)
% returns the index i corresponding to the given vector v
% this is only for the grid with N=8

v = mod(v,3);
if v(1) == 1
    if v(2) == 0
        i = 5;
    elseif v(2) == 1
        i = 6;
    else %v(2) == 2
        i = 4;
    end
elseif v(1) == 2
    if v(2) == 0
        i = 1;
    elseif v(2) == 1
        i = 8;
    else %v(2) == 2
        i = 2;
    end
else %v(1) == 0
    if v(2) == 0
        i = 0;
    elseif v(2) == 1
        i = 7;
    else %v(2) == 2
        i = 3;
    end
end
end
