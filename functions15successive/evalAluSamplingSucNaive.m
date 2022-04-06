function val = evalAluSamplingSucNaive(u,Psi,l,v,p,tau,N,totalSamples)
val = 0;
eta = zeros([1,N]);
eta(1:l) = 1;

if sum(eta) == 0 || sum(eta) == N
    totalSamples = 1;
end 

for sample = 1:totalSamples
    eta = eta(randperm(N));
    val = val + evalAuForEta(u,Psi,eta,v,p,tau);
end
val = val/totalSamples;
end


