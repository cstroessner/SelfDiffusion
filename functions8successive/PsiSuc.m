function val = PsiSuc(eta,psiDatas)
val = 0;
for j = 1:numel(psiDatas)
    valnew = zeros([1,8]);
    psiData = psiDatas{j};
    for i = 1:8
        valnew(i) = psiData(i,eta(i)+1);
    end
    val = val + prod(valnew);
end
end