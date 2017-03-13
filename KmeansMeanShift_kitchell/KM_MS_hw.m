

%clear windows
clc
clear all
close all

%% input image
I = imread('cat.jpg');
%% parameters

% kmeans parameter
K = 15;

% meanshift parameter
bw = 0.15;

%% apply functions
Ikm          = Km(I,K);
Ikm2         = Km2(I,K);
Ikm_man      = Km_manhattan(I,K);
[Ims, Nms]   = Ms(I,bw);
[Ims2, Nms2] = Ms2(I,bw);

%% show
figure()
subplot(231); imshow(I);    title('Original'); 
subplot(232); imshow(Ikm);  title(['Kmeans',' : ',num2str(K)]);
subplot(233); imshow(Ikm2); title(['Kmeans+Spatial',' : ',num2str(K)]); 
subplot(234); imshow(Ims);  title(['MeanShift',' : ',num2str(Nms)]);
subplot(235); imshow(Ims2); title(['MeanShift+Spatial',' : ',num2str(Nms2)]);
subplot(236); imshow(Ikm_man); title(['Kmeans+Manhattan',' : ',num2str(K)]);