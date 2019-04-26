function [A,B,C,D,E,F,g1,h1,i1 ] = FeaturesSelection( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%
h=waitbar(0,'Please wait..');
n=0;
for i=1:100
    waitbar(i/100)
    for j=1:100
        for k=0:100;
            n=factorial(2);
        end
    end
end
close(h)
%helpdg('Feature Extraction Completed..')
%% 
im=imread (img);
% [i,j]=size(im);
% for i=1:350
%     for j=1:250
h=rgb2gray(im);
G=double(rgb2gray(im)); 
clc;
%%
[A,B]=size(h);
r1=1/A-B;
i=100;
j=100;
for A=A-j
    for B=B-j
       r2=[i-A,j-B];
       r3=mean(r2);
     end
end
r4=-(r3*r2*r1);
format short
% disp([r4,r5]);
A = r4;
%%
maxValue = max(G(:));
B = maxValue;
[rowsOfMaxes ,colsOfMaxes] = find(G == maxValue);
Min_Value = min(G(:));
C = maxValue;
[row,column]=find(G == Min_Value);
intensityValue = G(100, 230); 
meanIntensityValue = mean(G(:));
format short
D = meanIntensityValue;
%% 
stats = regionprops(G,'Centroid',...
    'MajorAxisLength','MinorAxisLength');
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;
Aera =pi * diameters^2 / 4;
E=diameters;
measurements = regionprops(G,'Perimeter');
Perimeters = [measurements.Perimeter];
Perimeters= pi^2 * diameters^2;
c1=4*pi*Aera;
fc=Perimeters/c1;
F = fc;
%% 
m=size(G,1);
n=size(G,2);
AR=m/n;
g1 = AR;
%%
[Gx, Gy]=gradient(G);
S=sqrt(Gx.*Gx+Gy.*Gy);
sharpness=sum(sum(S))./(numel(Gx));
h1 = sharpness;
%%
GLCM2 = graycomatrix(h,'Offset',[2 0;0 2]);
GLCM=mean(GLCM2);
format short
stats = graycoprops(GLCM2,{'correlation','energy','Contrast','Homogeneity'}) ;
disp(stats);
p = bsxfun(@rdivide,GLCM2,sum(sum(GLCM2,1),2));
numGLCMs = size(p,3);
entropyVals = zeros(1,numGLCMs);
for ii=1:numGLCMs,
    p1 = p(:,:,ii);
    entropyVals(ii) = -sum(p1(p1>0).*log(p1(p1>0)));
end
i1 = entropyVals(ii);
