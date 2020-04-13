function PixelWeightVector = ProcessRegionDelta(Delta_off, CroppedImage, Neighbourhood_i, h, mu_1, gamma)
    sigma=1-gamma;
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
            %thresholding is performed below
            Neighbourhood_i_variance=var(Neighbourhood_i);
            Neighbourhood_j_variance=var(Neighbourhood_j);
            Neighbourhood_i_mean=mean(Neighbourhood_i);
            Neighbourhood_j_mean=mean(Neighbourhood_j);
            if((mu_1<(Neighbourhood_i_mean/Neighbourhood_j_mean) && (Neighbourhood_i_mean/Neighbourhood_j_mean)<(1/mu_1)) && ((sigma<(Neighbourhood_i_variance/Neighbourhood_j_variance)) && ((Neighbourhood_i_variance/Neighbourhood_j_variance)<(1/sigma))))
                PixelWeightVector(i,j)=Weight_ij;
            else
                PixelWeightVector(i,j)=0;
            end
        end
    end

    PixelWeightVector=PixelWeightVector./sum(sum(PixelWeightVector));
    PixelWeightVector(isNan(PixelWeightVector))=0;
    
    
    
    
    