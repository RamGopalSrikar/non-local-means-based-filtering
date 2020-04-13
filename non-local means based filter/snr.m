function snr_ij= snr(i, j)


sub = (i - j);
den = sum(sum(sub.^2))
num = sum(sum((i.^2)+(j.^2)))

s = 10 .* log10(num./den);

snr_ij= s;