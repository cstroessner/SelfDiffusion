function val = Psi(eta,psiData)
val = zeros([1,24]);
for i = 1:24
    val(i) = psiData(i,eta(i)+1);
end
val = prod(val);
end