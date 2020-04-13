clc
clear all
close all

%P_or = phantom('Modified Shepp-Logan',256);
P_or=imread('phantom_clean.png');
figure;
imshow(P_or);

P=(0.5+P_or)*20;
sigma=0.4;
var=sigma.^2;
 nor_dist=random('norm',0,sigma,[256,256]);
 P_noisy=P+(P.*nor_dist);
P_noisy=P_noisy/max(max(P_noisy));
 figure;
imshow(P_noisy);

[RestoredImage]= NLMBlockWise1(P_noisy,11,2,25,2);
RestoredImage=RestoredImage(2:257,2:257);
RestoredImage=RestoredImage/max(max(RestoredImage));
figure;
imshow(RestoredImage);


snr(P_or,P_noisy)

snr(P_or,RestoredImage)