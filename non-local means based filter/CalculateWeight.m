function Weight_ij= CalculateWeight(Neighbourhood_i, Neighbourhood_j, h)

i = Neighbourhood_i;
j = Neighbourhood_j;


sub = (i - j);

squ = sub.^2;

S = sum(squ);

w = S/(h.^2);

Weight_ij= exp(-w);

