function [psi] = getPsiFunctionsSuc(psiDatas)
psi = @(eta) 0;
for i = 1:numel(psiDatas)
psiData = psiDatas{i};
psi1 = psiData(1,:);
psi2 = psiData(2,:);
psi3 = psiData(3,:);
psi4 = psiData(4,:);
psi5 = psiData(5,:);
psi6 = psiData(6,:);
psi7 = psiData(7,:);
psi8 = psiData(8,:);
psiTmp = @(eta) psi1(eta(1)+1)*psi2(eta(2)+1)*psi3(eta(3)+1)*psi4(eta(4)+1)*psi5(eta(5)+1)*psi6(eta(6)+1)*psi7(eta(7)+1)*psi8(eta(8)+1);
psi = @(eta) psi(eta)+psiTmp(eta);
end
end