function val = PsiSuc(eta,psiDatas)
val = 0;
for j = 1:numel(psiDatas)
    valnew = zeros([1,15]);
    psiData = psiDatas{j};
    for i = 1:15
        valnew(i) = psiData(i,eta(i)+1);
    end
    val = val + prod(valnew);
end
end