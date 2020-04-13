function [RestoredImage]= NLMBlockWise1(NoisyImage,Delta,d,h,stride)

[M,K]=size(NoisyImage);

N=(2*d+1);
region_length=(floor(N/2)*2+Delta);
padding_width=floor(region_length/2);
padded_image=padding(NoisyImage,padding_width);
offset=floor(N/2);
count=zeros(M+stride,K+stride);
RestoredImage=zeros(M+stride,K+stride);
stride1=stride-1;

for i=stride:stride:M
    for j=stride:stride:K
        crop_image=padded_image(i:i+(2*padding_width),j:j+(2*padding_width));
        neighbour_N=reshape(crop_image(padding_width+1-offset:padding_width+1+offset,padding_width+1-offset:padding_width+1+offset),1,[]);
        PixelWeightVector = ProcessRegionDelta(Delta, crop_image, neighbour_N,h);
        RestoredValue=sum(sum(crop_image(1+offset:end-offset,1+offset:end-offset).*PixelWeightVector)); 
        RestoredImage(i-stride1:i+stride1,j-stride1:j+stride1)= RestoredImage(i-stride1:i+stride1,j-stride1:j+stride1)+RestoredValue;
        count(i-stride1:i+stride1,j-stride1:j+stride1)= count(i-stride1:i+stride1,j-stride1:j+stride1)+1;
          
    end
end

RestoredImage=RestoredImage./count;
assignin('caller','count',count);



        