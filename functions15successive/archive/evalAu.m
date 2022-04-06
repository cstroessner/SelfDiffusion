function val = evalAu(u,psiData,v,p,tau,N)
warning('This function is unstable.\n')

val = 0;
for k = 1:numel(v)
    uv = u*v{k}';
    valnew = 0;
    for i = 1:N
        if tau(k,i) > 0
            sum1 = 1; sum2 = 1;
            swaps = 1:N;
            swaps(i) = tau(k,i);
            swaps(tau(k,i)) = i;
            for j = 1:N
                sum1 = sum1 * ((psiData(j,1)).^2 + (psiData(j,2)).^2); 
                sum2 = sum2 * (psiData(swaps(j),1)* psiData(j,1) + psiData(swaps(j),2)* psiData(j,2) );
            end
            valnew = valnew + 2*sum1 - 2*sum2;
        end
    end
    
    sum3 = 1; sum6 = 1;
    for j = 1:N
        if j ~= tau(k,vecIndex(v{k}))
            sum3 = sum3 * ((psiData(j,1)).^2 + (psiData(j,2)).^2);
            sum6 = sum6 * ((psiData(j,1)) + (psiData(j,2)));
        else
            sum3 = sum3 * psiData(j,1).^2;
            sum6 = sum6 * psiData(j,1);
        end
    end
    
    sum4 = 1; sum7 = 1;
    for j = 1:N
        if j ~= vecIndex(v{k})
            sum4 = sum4 * ((psiData(j,1)).^2 + (psiData(j,2)).^2);
            sum7 = sum7 * ((psiData(j,1)) + (psiData(j,2)));
        else
            sum4 = sum4 * psiData(j,1).^2;
            sum7 = sum7 * psiData(j,1);
        end
    end
    
    sum5 = 1;
    swaps = etaShift(1:24,k,tau);
    for j = 1:N
        if isempty(find(swaps == j,1)) == 0
            sum5 = sum5 * (psiData(j,1)*psiData((swaps ==j),1) +  psiData(j,2)*psiData((swaps ==j),2));
        else
            sum5 = sum5 * (psiData(j,1))*psiData((swaps == 0),1);
        end
    end
   
    valnew = valnew + sum3 + sum4 - 2*sum5 + 2*sum6*uv - 2*sum7*uv + 2^(N-1)*uv^2;
    valnew = valnew*p(k);
    val = val + valnew;
end
end