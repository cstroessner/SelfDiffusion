function psiData = renormalize(psiData)
N = size(psiData,1);

for iters = 1:N
v = abs(sum(psiData,2));
[alpha,I] = max(v);
[beta,J] = min(v);
gamma = sqrt(alpha*beta);
psiData(I,:) = gamma*psiData(I,:)/alpha;
psiData(J,:) = gamma*psiData(J,:)/beta;
end

end