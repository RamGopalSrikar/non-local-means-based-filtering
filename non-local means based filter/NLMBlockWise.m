function [RestoredImage]= NLMBlockWise(NoisyImage,Delta,d,h,stride)

[M,K]=size(NoisyImage);

N=(2*d+1);
region_length=(floor(N/2)*2+Delta);
padding_width=floor(region_length/2);
padded_image=padding(NoisyImage,padding_width);
offset=floor(N/2);
count=zeros(size(NoisyImage));
RestoredImage=zeros(size(NoisyImage));


stride1=stride-1;

for i=1:stride:M
    for j=1:stride:K
        crop_image=padded_image(i:i+(2*padding_width),j:j+(2*padding_width));
        neighbour_N=reshape(crop_image(padding_width+1-offset:padding_width+1+offset,padding_width+1-offset:padding_width+1+offset),1,[]);
        PixelWeightVector = ProcessRegionDelta(Delta, crop_image, neighbour_N,h);
        
        
        RestoredValue=sum(sum(crop_image(1+offset:end-offset,1+offset:end-offset).*PixelWeightVector));
    
          if(i==1)
              if(j==1)
                  for l=i:i+stride1
                      for m=j:stride
                          
                          RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                          count(l,m)=count(l,m)+1;
                      end
                  end
              elseif(j==K)
                  for l=i:i+stride1
                      for m=j-stride1:j
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              elseif(K-stride<j<K)
                  for l=i:i+stride1
                      for m=j-stride1:K
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              else
                  for l=i:i+stride1
                      for m=j-stride1:j+stride1
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              end
          
          elseif(j==1)
              if(i==M)
                  for l=i-stride1:i
                      for m=j:j+stride1
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              elseif(M-stride<i<M)
                  for l=i-stride1:M
                      for m=j:j+stride1
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              else
                  for l=i-stride1:i+stride1
                      for m=j:j+stride1
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              end
          
          elseif(i==M)
              if(j==1)
                  for l=i-stride+1:i
                      for m=j:j+stride1
                          RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
                  
              elseif(j==N)
                  for l=i-stride1:i
                      for m=j-stride1:j
                          RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
                  
              elseif(K-stride<j<K)
                  for l=i-stride1:i
                      for m=j-stride1:K
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
                  
              else
                  for l=i-stride1:i
                      for m=j-stride1:j+stride1
                          RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              end
          
          elseif(j==K)
              if(i==1)
                  for l=i:i+stride1
                      for m=j-stride1:j
                          RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              elseif(M-stride<i<M)
                  for l=i-stride1:M
                      for m=j-stride1:K
                          RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              else
                  for l=i-stride1:i+stride1
                      for m=j-stride1:j
                          RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              end
          elseif((K-stride<j<K) || (M-stride<i<M))
              if( (K-stride<j<K) && (M-stride<i<M))
                  for l=i-stride1:M
                      for m=j-stride1:K
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              elseif (K-stride<j<K)
                  for l=i-stride1:i+stride1
                      for m=j-stride1:K
                         
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
              elseif(M-stride<i<M)
                  for l=i-stride1:M
                      for m=j-stride1:j+stride1
                           RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
                  end
          
              end  
          else
               
              for l=i-stride1:i+stride1
                      for m=j-stride1:j+stride1s
                          RestoredImage(l,m)=RestoredImage(l,m)+RestoredValue;
                            count(l,m)=count(l,m)+1;
                      end
              end  
          end       
        
    end
end

RestoredImage=RestoredImage./count;
RestoredImage(find(isnan(RestoredImage)))=0;
assignin('caller','count',count);


        