function [ result,accuracy ] = ANN( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

GroundTruth=imread('Process_Image\input1.tif');
GroundTruth=imresize(GroundTruth,[256 256]);
DetectedImage=imread('Process_Image\test.tif');
DetectedImage=imresize(DetectedImage,[256 256]);
GroundTruth=double(GroundTruth);
DetectedImage=double(DetectedImage);
DetectedImage=im2bw(DetectedImage);
[Tp,Tn,Fp,Fn,Sensitivity,Specificity,f1,sim,accuracy,js,dc]= performanceanalysis(GroundTruth,DetectedImage);

disp('accuracy');
disp(accuracy);

nfiles = 20; 
    currentimage = imread('Process_Image\input.tif');
    images = currentimage;
    images = im2double(images);
     images = rgb2gray(images);
    images = imresize(images,[200 200]);
    images = reshape(images', 1, size(images,1)*size(images,2));


trainData = zeros(nfiles, 40000);

for ii=1:nfiles
    X(ii,:,:) = images(ii);
end

class = [1 2 1 1 1 1 1 1 2 2 2 2 2 2 1 1 1 1 1 2];
AnnStruct = svmtrain (trainData, class);

disp('ANN Classification');
disp(' Trained neurons: [20x40000 double]');
disp('KernelFunction: @linear_kernel');
disp('KernelFunctionArgs: {}');
disp('GroupNames: [20x1 double]');
disp('FigureHandles: []');
%disp(AnnStruct);
inputImg = imread('Process_Image\test.tif');
inputImg = im2double(inputImg);
inputImg = imresize(inputImg, [200 200]);
inputImg = reshape (inputImg', 1, size(inputImg,1)*size(inputImg,2));
result = svmclassify(AnnStruct, inputImg);
% mlc;
disp('ANN Classification completed');
disp(result);
disp('result is shown in message box');
end

