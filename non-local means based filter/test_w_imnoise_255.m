clc
clear all 
close all

P_or = phantom('Modified Shepp-Logan',256);
%P_or=imread('phantom_clean.png');
P_or=uint32((P_or+(0.5))*(20));
figure;
imshow((P_or));
P=P_or;

sigma=0.4;
var=sigma.^2;
 nor_dist=random('norm',0,sigma,[256,256]);
 P_noisy=P+(P.*uint32(nor_dist));
 
figure;
imshow(uint32(P_noisy));


[RestoredImage]= NLMBlockWise1(P_noisy,11,2,25,2);
RestoredImage=RestoredImage(2:257,2:257);
figure;
imshow(uint32(RestoredImage));
int32

snr(P_or,P_noisy)

snr(P_or,(RestoredImage))
