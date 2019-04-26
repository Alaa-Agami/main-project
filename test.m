global img1
global result
global x
imagefiles = 'D:\Manikandan\2018\Palakkad\Nehru Mtech\divya\code\ram sir office\Skin Cancer code- Phase1';
%imgcount = 0;
imgcount = 23;
% D=dir(imagefiles);
% for i=1 : size(D,1)
% if not(strcmp(D(i).name,'.')|strcmp(D(i).name,'..')|strcmp(D(i).name,'Thumbs.db'))
% imgcount = imgcount + 1; % Number of all images in the training database
% end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%% creating the image matrix X %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = [];
for i = 1 : imgcount
str = strcat(imagefiles,'\',int2str(i),'.png');
currentimage = imread(str);
% currentfilename = imagefiles(i).name;
% currentimage = imread(currentfilename);
images{i} = currentimage;
images{i} = im2double(images{i});
Si=ndims(images{i});
if Si>2
images{i}=rgb2gray(images{i}); %Convert the Three Layered Image into Intensity Image with Grey Value
else
end
images{i} = imresize(images{i},[200 200]);
images{i} = reshape(images{i}', 1, size(images{i},1)*size(images{i},2));
end
trainData = zeros(imgcount, 40000);
for ii=1:imgcount
trainData(ii,:) = images{ii};
end

T=imread('7.png');
inputImg = T;
inputImg = im2double(inputImg);
Si=ndims(inputImg);
if Si>2
inputImg=rgb2gray(inputImg); %Convert the Three Layered Image into Intensity Image with Grey Value
else
end
inputImg = imresize(inputImg, [200 200]);
inputImg = reshape (inputImg', 1, size(inputImg,1)*size(inputImg,2));
C=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23]
rs=multisvm(trainData,C,inputImg);
disp(rs);