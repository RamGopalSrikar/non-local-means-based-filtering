close all
clear all
clc

Delta=10;
d=1;


% Read and display an image
load BrainWeb

% I=imread('cameraman.tif');
figure(1), imshow(I)
var=0.0015;

noisyimage=imnoise(I, 'gaussian', 0, var);

figure
imshow(noisyimage);

% image = 100*ones(100);
% image(50:100,:) = 50;
% image(:,50:100) = 2*image(:,50:100);
% fs = fspecial('average');
% image = imfilter(image,fs,'symmetric');
% % Add some noise
% var = 10;
% noisyimage = image + var*randn(size(image));
% figure;, imshow(uint8(noisyimage));

h=200*var;
tic
[RestoredImage]= NLMBlockWise1(im2double(noisyimage),Delta,d,h,2);
toc
figure, imshow((RestoredImage));

