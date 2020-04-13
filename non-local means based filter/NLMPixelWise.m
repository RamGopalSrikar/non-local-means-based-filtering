function [RestoredImage]= NLMPixelWise(NoisyImage,Delta,d,h)

[M,K]=size(NoisyImage);
RestoredImage=zeros(M,K);
N=(2*d+1);
region_length=(floor(N/2)*2+Delta);
padding_width=floor(region_length/2);
padded_image=padding(NoisyImage,padding_width);
offset=floor(N/2);
Delta_off=Delta+offset;
for i=1:M
    for j=1:K
        
        crop_image=padded_image(i:i+(2*padding_width),j:j+(2*padding_width));
        neighbour_N=reshape(crop_image(padding_width+1-offset:padding_width+1+offset,padding_width+1-offset:padding_width+1+offset),1,[]);
        PixelWeightVector = ProcessRegionDelta(Delta_off, crop_image, neighbour_N,h); 
        RestoredImage(i,j)=sum(sum(crop_image(1+offset:end-offset,1+offset:end-offset).*PixelWeightVector));
    end
end
        
        
        
        