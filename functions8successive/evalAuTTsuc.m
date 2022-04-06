function val = evalAuTTsuc(u,psiDatas,v,p,tau)
R = numel(psiDatas);
N = size(psiDatas{1},1);
K = numel(v);
val = 0;

T1cores = data2cores(psiDatas{1});
for r = 2:R
    T1cores = addTT(T1cores,data2cores(psiDatas{r}));
end
for k = 1:K
    newVal = 0;
    
    for i = 1:N
        if tau(k,i) > 0
            swap = etaSwap(1:N,i,tau(k,i));
            T2cores = data2cores(psiDatas{1}(swap,:));
            for r = 2:R
                T2cores = addTT(T2cores,data2cores(psiDatas{r}(swap,:)));
            end
            T12cores = addTT(negTT(T1cores),T2cores);
            newVal = newVal + frobNormTTorthog(T12cores);
        end
    end
    
    swaptmp = etaShift(1:N,k,tau);
    swaptmp(swaptmp == 0) = tau(k,0);
    for i = 1:N
        swap(i) = find(swaptmp==i);
    end
    tmpData = psiDatas{1}(swap,:);
    T2cores = data2cores(tmpData);
    for r = 2:R
        tmpData = psiDatas{r}(swap,:);
        T2cores = addTT(T2cores,data2cores(tmpData));
    end   
    T3cores = data2cores(ones(size(psiDatas{1})));
    T3cores{1} = u*v{k}'.*T3cores{1};
    TAcores = T1cores;
    TBcores = T2cores;
    TCcores = T3cores;
    if R > 1
        if tau(k,0) > 1 && tau(k,0) < N
            TAcores{tau(k,0)} = TAcores{tau(k,0)}(:,1,:);
            TBcores{tau(k,0)} = TBcores{tau(k,0)}(:,1,:);
            TCcores{tau(k,0)} = TCcores{tau(k,0)}(:,1,:);
        elseif tau(k,0) == 1
            TAcores{tau(k,0)} = TAcores{tau(k,0)}(1,:);
            TBcores{tau(k,0)} = TBcores{tau(k,0)}(1,:);
            TCcores{tau(k,0)} = TCcores{tau(k,0)}(1,:);
        else %tau(k,0) == N
            TAcores{tau(k,0)} = TAcores{tau(k,0)}(:,1);
            TBcores{tau(k,0)} = TBcores{tau(k,0)}(:,1);
            TCcores{tau(k,0)} = TCcores{tau(k,0)}(:,1);            
        end
    else
        TAcores{tau(k,0)} = TAcores{tau(k,0)}(1);
        TBcores{tau(k,0)} = TBcores{tau(k,0)}(1);
        TCcores{tau(k,0)} = TCcores{tau(k,0)}(1);
    end
    TABcores = addTT(negTT(TAcores),TBcores);
    TABCcores = addTT(TABcores,TCcores);
    newVal = 0.5 * newVal + frobNormTTorthog(TABCcores); %ADDED 1/2
    val = val + p(k)*newVal;
    
    %for debugining only
    %TABC = TTfullTensor(TABCcores);
end

%depug only below
% valControl = 0;
% psi = getPsiFunctions(psiDatas{1});
% for r = 2:R
%     psiTmp = getPsiFunctions(psiDatas{r});
%     psi = @(eta) psi(eta) + psiTmp(eta);
% end
% 
% valueTensor = squeeze(T1cores{1}(1,:))*squeeze(T1cores{2}(:,2,:))*squeeze(T1cores{3}(:,1,:))*squeeze(T1cores{4}(:,1,:))...
%     *squeeze(T1cores{5}(:,1,:))*squeeze(T1cores{6}(:,1,:))*squeeze(T1cores{7}(:,1,:))*squeeze(T1cores{8}(:,1))
% eta = [0,1,0,0,0,0,0,0];
% valueFunction = psi(eta)
% errValue = norm(valueTensor-valueFunction)
% 
% valueTensorShift = squeeze(T2cores{1}(1,:))*squeeze(T2cores{2}(:,2,:))*squeeze(T2cores{3}(:,1,:))*squeeze(T2cores{4}(:,1,:))...
%     *squeeze(T2cores{5}(:,1,:))*squeeze(T2cores{6}(:,1,:))*squeeze(T2cores{7}(:,1,:))*squeeze(T2cores{8}(:,1))
% valueFunctionShift = psi(etaShift(eta,k,tau))
% errShift = norm(valueTensorShift-valueFunctionShift)
% 
% Etas = dec2bin(0:2^N-1)' - '0';
% for i = 1:size(Etas,2)
%     eta = Etas(:,i);
%     valControl = valControl +  evalAuforEta(u,psi,eta,v,p,tau);
% end
% 
% err3 = norm(val - valControl)
end

% % debug only
% function val = evalAuforEta(u,psi,eta,v,p,tau)
% K = numel(v);
% N = numel(eta);
% val = 0;
% for k = 1:K
%     if eta(vecIndex(v{k})) == 0
%         newVal =  p(k)*(u*v{k}' + psi(etaShift(eta,k,tau)) - psi(eta) )^2;
%         val = val + newVal;
%     end
% end
% for k = 1:K
%     for i = 1:N
%         if tau(k,i) > 0
%             etaSw = etaSwap(eta,i,tau(k,i));
%             if max(eta-etaSw ~= 0) % if eta = etaSw there is no need to evaluate psi at all
%                 newVal = p(k) *( psi(etaSw) - psi(eta) )^2;
%                 val = val + newVal;
%             end
%         end
%     end
% end
% end
% 
% %debug only
% function [psi,psis] = getPsiFunctions(psiData)
% psi1 = psiData(1,:);
% psi2 = psiData(2,:);
% psi3 = psiData(3,:);
% psi4 = psiData(4,:);
% psi5 = psiData(5,:);
% psi6 = psiData(6,:);
% psi7 = psiData(7,:);
% psi8 = psiData(8,:);
% psi = @(eta) psi1(eta(1)+1)*psi2(eta(2)+1)*psi3(eta(3)+1)*psi4(eta(4)+1)*psi5(eta(5)+1)*psi6(eta(6)+1)*psi7(eta(7)+1)*psi8(eta(8)+1);
% psis = {@(x) psi1(x+1),@(x) psi2(x+1),@(x) psi3(x+1),@(x) psi4(x+1),@(x) psi5(x+1) ,@(x) psi6(x+1) ,@(x) psi7(x+1) ,@(x)psi8(x+1)};
% end
% 
% % debug only
% function T = TTfullTensor(U)
% % creating a full tensor out of TT cores U
% d = length(U);
% n = zeros(d,1);
% r = zeros(d+1,1);
% r(end) = 1;
% n(1) = size(U{1},1);
% r(1) = size(U{1},2);
% for mu = 2:d
%     n(mu) = size(U{mu}, 2);
%     r(mu) = size(U{mu}, 1);
% end
% T = U{1};
% for mu = 2:d
%     if r(mu) == 1
%         T = reshape(T,[numel(T),1]) * tenmat(U{mu},1);
%     else
%         T = tenmat(T, ndims(T))' * tenmat(U{mu}, 1);
%     end
%     T = reshape(T, [n(1:mu)', r(mu+1)]);
% end
% end

function Xn = tenmat(X, n)
%computes the mode n matrizisation of a tensor X
N = ndims(X);
sz = size(X);
if numel(sz) < 4
    sz = [size(X,1),size(X,2),size(X,3),size(X,4)];
end
j = 1;
for i = 1:N
    if i ~= n
        m(j) = i;
        j = j+1;
    end
end
X = permute(X,[n m]);
Xn = reshape(X, sz(n), prod(sz(m)));
end

function Y = ttm(X, A, n)
Y = tenmat(X, n);
Y = A * Y;
sz = size(X);
sz2 = [size(A,1), sz(1:(n-1)), sz((n+1):end)];
Y = reshape(Y, sz2);
perm = [2:n, 1, (n+1):length(sz)];
Y = permute(Y, perm);
end

function val = frobNormTTorthog(U)
%left orthogonalization with immediate evaluation of the squared frob norm
N = size(U,1);
for mu = 1:N-1
    if mu > 1
        UL = tenmat(U{mu}, 3)';
    else
        UL = tenmat(U{mu},2)';
    end
    [Q, R] = qr(UL,0);
    if mu == 1
        U{mu} = reshape(Q,size(U{mu},1),[]);
    elseif mu == 2
        U{mu} = reshape(Q, size(U{mu-1},2),size(U{mu},2),[]);
    else
        U{mu} = reshape(Q, size(U{mu-1},3),size(U{mu},2),[]);
    end
    U{mu+1} = ttm(U{mu+1}, R, 1);
end
val = sum(U{N}.^2,'all');

end

function W = addTT(U,V)
N = size(U,1);
W = cell(size(U));
W{1} = zeros([size(U{1},1),size(U{1},2)+size(V{1},2)]);
W{1}(1:size(U{1},1),1:size(U{1},2)) = U{1};
W{1}(1:size(U{1}),size(U{1},2)+1:end) = V{1};
for i = 2:N-1
    W{i} = zeros([size(U{i},1)+size(V{i},1),size(U{i},2),size(U{i},3)+size(V{i},3)]);
    W{i}(1:size(U{i},1),1:size(U{i},2),1:size(U{i},3)) = U{i};
    W{i}(size(U{i},1)+1:end,1:size(U{i},2),size(U{i},3)+1:end) = V{i};
end
W{N} = zeros([size(U{N},1)+size(V{N},1),size(U{N},2)]);
W{N}(1:size(U{N},1),1:size(U{N},2)) = U{N};
W{N}(size(U{N},1)+1:end,1:size(U{N},2)) = V{N};
end

function U = negTT(U)
U{1} = -U{1};
end

function U = data2cores(psiData)
U = cell(size(psiData,1),1);
U{1} = psiData(1,:)';
for i = 2: size(psiData,1)
    U{i} = psiData(i,:);
end
end