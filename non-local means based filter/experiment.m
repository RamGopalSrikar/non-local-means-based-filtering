clc
clear all 
close all

P_or = (phantom('Modified Shepp-Logan',256)*((2^16)-1));
%P_or=imread('phantom_clean.png');
P_or=((P_or+(0.5)));
figure;
imshow(uint16(P_or));
P=P_or;
sigma=0.4;
var=sigma.^2;
 nor_dist=random('norm',0,sigma,[256,256]);
 P_noisy=P+(P.*(nor_dist));
%  sigma=0.4;
% var=sigma.^2;
% P_noisy=imnoise(uint16(P_or), 'speckle', var);

figure;
imshow(uint16(P_noisy));


[RestoredImage]= NLMBlockWise1(uint16(P_noisy),11,2,25,2);
RestoredImage=RestoredImage(2:257,2:257);
figure;
imshow(uint16(RestoredImage));


snr(P_or,double(P_noisy))

snr(P_or,(RestoredImage))
