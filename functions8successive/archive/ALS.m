function [psiData,val] = ALS(u,psiData,v,p,tau,N)
decay = 1e54; iters = 1; val(iters) =  evalAuTT(u,psiData,v,p,tau); psiData = renormalize(psiData);
while decay > 1e-5*abs(val(iters)) && iters < 1500
    for mode = 1:N
        psiDataNew = optimizeMode(mode,u,psiData,v,p,tau,N);
        iters = iters+1;
        newVal = evalAuTT(u,psiDataNew,v,p,tau);
        if newVal <= 0
            warning('Negative value reached. Return previous psiData.\n')
            return
        end
        psiData = renormalize(psiDataNew);
        val(iters) =  newVal;
        if newVal-val(iters-1) > 0
            warning('ALS not decaying %i',iters)
        end
    end
    decay = val(iters-N)-val(iters);
end
fprintf('als converged at iteration %i to a solution with value %d.\n',iters,newVal)
end

function psiDataNew = optimizeMode(mode,u,psiData,v,p,tau,N)

    if mode == 1
        psiDataFun = @(a,b) [a,b; psiData(2:end,:)];
    elseif mode == N
        psiDataFun = @(a,b) [psiData(1:end-1,:);a,b];
    else
        psiDataFun = @(a,b) [psiData(1:mode-1,:);a,b; psiData(mode+1:end,:)];
    end
    evalAB = @(a,b)evalAuTT(u,psiDataFun(a,b),v,p,tau);

    x = [1, 0.7, 0.8,1.2,1.1,1.3];
    y = [0.7, 1, 1.2,0.9,0.6,0.75];
    for i = 1:numel(x)
        f(i) = evalAB(x(i),y(i));
    end
    poly = fit([x', y'], f', 'poly22'); %poly seems to be correct, the values match with evalAB (rel errs 1e-14)
    alpha = coeffvalues(poly);
    alpha = alpha([4,6,5,2,3,1]);
    
    %absErrAlpha = max(abs([(alpha1-alpha(1))/alpha1, (alpha2-alpha(2))/alpha2, (alpha3-alpha(3))/alpha3])) % for debuging only
    
    minIsUniqueAndExists = min(eigs([2*alpha(1),alpha(3);alpha(3),2*alpha(2)]) > 0);
    if ~minIsUniqueAndExists
        warning('the polynomial does not have a minimum')
        psiDataNew = psiData; return
    else
       %fprintf('New param update.\n') 
    end
    
    newparams = [2*alpha(1), alpha(3); alpha(3), 2*alpha(2)]\[-alpha(4);-alpha(5)];
    if mode == 1
        psiDataNew = [newparams';psiData(2:end,:)];
    elseif mode == N
        psiDataNew = [psiData(1:end-1,:);newparams'];
    else
        psiDataNew = [psiData(1:mode-1,:);newparams'; psiData(mode+1:end,:)];
    end

end
