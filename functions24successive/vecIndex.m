function i = vecIndex(v)
% returns the index i corresponding to the given vector v
% hardcoded for N = 24

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
