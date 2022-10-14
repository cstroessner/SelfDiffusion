function val = PsiSuc(eta,psiDatas)
val = 0;
N = 35;
for j = 1:numel(psiDatas)
    valnew = zeros([1,N]);
    psiData = psiDatas{j};
    for i = 1:N
        valnew(i) = psiData(i,eta(i)+1);
    end
    val = val + prod(valnew);
end
end