function padded_image =padding(NoisyImage,padding_width)

img=NoisyImage;
 
 
p=padding_width;  

padded_image=zeros(size(img)+2*p);  

for x=1:size(img,1)
            for y=1:size(img,2)
                padded_image(x+p,y+p)=img(x,y); 
            end
end

%figure,imshow(img)
%figure,imshow(padd) 