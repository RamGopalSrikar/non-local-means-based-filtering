clc
clear all
close all

x=0.1:0.1:255;
y=0.1:0.1:255;

[xx,yy]=meshgrid(x,y);

z=zeros(size(xx));
for i=1:length(x)
    for j=1:length(y)
        sub = (xx(i,j) - yy(i,j));
        den = sub.^2;
        num = (xx(i,j).^2)+(yy(i,j).^2);
        if(sub~=0)
            z(i,j) = 10 .* log10(num./den);
        else
            z(i,j) =0;
        end
    end
end

mesh(xx,yy,z);