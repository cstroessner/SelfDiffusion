function eta = etaSwap(eta,i,j) 
% modifies eta by swapping the values at indices i and j

tmp = eta(j);
eta(j) = eta(i);
eta(i) = tmp;
end


