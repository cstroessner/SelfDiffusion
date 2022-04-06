function [totalVal,totalSamples] = evalAluNormalizedSamplingImproved(u,psi,beta,l,v,p,tau,N,innerSamples)
% estimate Alu using a variance reduction by ensuring the positions
% reachable by the tagged particle are sampled completely
% WARNING: this only works for the default vectors v_k so far
totalSamples = 0;
totalVal = 0;
Etas = dec2bin(0:2^4-1)' - '0';
for i = 1:size(Etas,2)
    innerEta = Etas(:,i);
    innerVals = sum(innerEta);
    outerVals = l-innerVals;
    if l-innerVals >= 0 && outerVals >= 0 && outerVals <= 20
        outerEta = zeros([20,1]);
        outerEta(1:outerVals) = 1;
        curVal = 0;
        if  outerVals == 0 || outerVals == 20
            eta = zeros([N,1]);
            eta(1:2:7) = innerEta;
            eta([2:2:8,9:24]) = outerEta;
            totalSamples = totalSamples +1;
            curVal = evalAuForEtaNormalized(u,psi,beta,eta,v,p,tau);
        else
            for s = 1:innerSamples
                outerEta = outerEta(randperm(20));
                eta = zeros([N,1]);
                eta(1:2:7) = innerEta;
                eta([2:2:8,9:24]) = outerEta;
                totalSamples = totalSamples +1;
                curVal = curVal + evalAuForEtaNormalized(u,psi,beta,eta,v,p,tau);
            end
            curVal = curVal/innerSamples*nchoosek(20,outerVals);
        end
        totalVal = totalVal + curVal;
    end
end
totalVal = totalVal/nchoosek(N,l);
end

function val = evalAuForEtaNormalized(u,psiData,beta,eta,v,p,tau)
K = numel(v);
N = numel(eta);
val = 0;
for k = 1:K
    if eta(vecIndex(v{k})) == 0
        newVal =  p(k)*(u*v{k}' + beta*Psi(etaShift(eta,k,tau),psiData) - beta*Psi(eta,psiData) )^2;
        val = val + newVal;
    end
end
for k = 1:K
    for i = 1:N
        if tau(k,i) > 0
            etaSw = etaSwap(eta,i,tau(k,i));
            if max(eta-etaSw ~= 0) % if eta = etaSw there is no need to evaluate psi at all
                newVal = p(k) *( beta*Psi(etaSw,psiData) - beta*Psi(eta,psiData) )^2;
                val = val + newVal;
            end
        end
    end
end
end