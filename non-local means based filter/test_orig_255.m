clc
clear all 
close all

P_or = phantom('Modified Shepp-Logan',256);
%P_or=imread('phantom_clean.png');
P_or=uint8((P_or+(0.5)));
figure;
imshow((P_or));

sigma=0.4;
var=sigma.^2;
P_noisy=imnoise(P_or, 'speckle', var);

figure;
imshow(uint8(P_noisy));


[RestoredImage]= NLMBlockWise1(P_noisy,11,2,25,2);
RestoredImage=RestoredImage(2:257,2:257);
figure;
imshow(uint8(RestoredImage));


snr(P_or,P_noisy)

snr(P_or,uint8(RestoredImage))
