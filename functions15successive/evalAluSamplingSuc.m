function [totalVal,totalSamples] = evalAluSamplingSuc(u,Psi,l,v,p,tau,N,innerSamples)
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
    if l-innerVals >= 0 && outerVals >= 0 && outerVals <= 11
        outerEta = zeros([11,1]);
        outerEta(1:outerVals) = 1;
        curVal = 0;
        if  outerVals == 0 || outerVals == 11
            eta = zeros([N,1]);
            eta([1,3,4,12]) = innerEta;
            eta([2,5:11,13:15]) = outerEta;
            totalSamples = totalSamples +1;
            curVal = evalAuForEta(u,Psi,eta,v,p,tau)/nchoosek(N,l);
        else
            for s = 1:innerSamples
                outerEta = outerEta(randperm(11));
                eta = zeros([N,1]);
                eta([1,3,4,12]) = innerEta;
                eta([2,5:11,13:15]) = outerEta;
                totalSamples = totalSamples +1;
                curVal = curVal + evalAuForEta(u,Psi,eta,v,p,tau);
            end
            curVal = curVal/innerSamples*(nchoosek(11,outerVals)/nchoosek(N,l));
        end
        totalVal = totalVal + curVal;
    end
end
end