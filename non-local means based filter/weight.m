function Weight_ij= weight(i, j, h)


% i = [1 2 3 6];
% j = [1 6 3 0];
% h=3;
gamma = 0.5;

sub = (i - j);

squ = sub.^2;

dis = (squ./(j.^(2*gamma)));
dis(isinf(dis)|isnan(dis)) =0;
dis_sum = sum(dis);

w = dis_sum./(h.^2);

Weight_ij= exp(-w);