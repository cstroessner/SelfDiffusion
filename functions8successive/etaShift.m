function etaNew = etaShift(eta,k,tau) 
% returns the state eta after moving the tagged particle in the direction v_k
for i = 1:8
    if tau(k,i) > 0
        etaNew(i) = eta(tau(k,i));
    else
        etaNew(i) = 0;
    end
end
end

