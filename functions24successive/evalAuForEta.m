function val = evalAuForEta(u,psi,eta,v,p,tau)
K = numel(v);
N = numel(eta);
val = 0;
for k = 1:K
    if eta(vecIndex(v{k})) == 0
        newVal =  p(k)*(u*v{k}' + psi(etaShift(eta,k,tau)) - psi(eta) )^2;
        val = val + newVal;
    end
end
for k = 1:K
    for i = 1:N
        if tau(k,i) > 0
            etaSw = etaSwap(eta,i,tau(k,i));
            if max(eta-etaSw ~= 0) % if eta = etaSw there is no need to evaluate psi at all
                newVal = p(k) *( psi(etaSw) - psi(eta) )^2;
                val = val + 0.5 * newVal; %ADDED 1/2
            end
        end
    end
end
end