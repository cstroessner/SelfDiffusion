function eta = I2Eta(I)
[eta1,eta2,eta3,eta4,eta5,eta6,eta7,eta8] = ind2sub([2,2,2,2,2,2,2,2],I);
eta = [eta1,eta2,eta3,eta4,eta5,eta6,eta7,eta8]-1;
end

