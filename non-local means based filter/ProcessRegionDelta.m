function PixelWeightVector = ProcessRegionDelta(Delta_off, CroppedImage, Neighbourhood_i, h)
    
    neighbourhood_vector_length= size(Neighbourhood_i,2);
    neighbourhood_edge_length=sqrt(neighbourhood_vector_length);
    offset=floor(neighbourhood_edge_length/2);
    [M,N]=size(CroppedImage);
    PixelWeightVector=zeros(M-(2*offset),N-(2*offset));
    for i=offset:M-(2*offset)
        for j=offset:N-(2*offset)
            patch_j=CroppedImage(i:i+(2*offset),j:j+(2*offset));
            Neighbourhood_j=reshape(patch_j,[1,neighbourhood_edge_length.^2]);
            Weight_ij= weight(Neighbourhood_i, Neighbourhood_j, h);
            PixelWeightVector(i,j)=Weight_ij;
        end
    end

    PixelWeightVector=PixelWeightVector./sum(sum(PixelWeightVector));
    
    