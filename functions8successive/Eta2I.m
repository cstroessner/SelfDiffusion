function I = Eta2I(eta)
eta1 = eta(1)+1;
eta2 = eta(2)+1;
eta3 = eta(3)+1;
eta4 = eta(4)+1;
eta5 = eta(5)+1;
eta6 = eta(6)+1;
eta7 = eta(7)+1;
eta8 = eta(8)+1;
I = sub2ind([2,2,2,2,2,2,2,2],eta1,eta2,eta3,eta4,eta5,eta6,eta7,eta8);
end