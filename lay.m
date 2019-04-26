function [ output_args ] = lay( I )
%UNTITLED2 Summary of this function goes here
A = I;
C=A;

C(C<100)=0;

s= strel('disk',4,0);  %Img Structure

D= ~im2bw(C); %Create Binary IMG

L = bwareaopen(D,400); % Remove unwanted px ( default 400 px)

E = imclearborder(L); %Clear borders

I = imfill(E,'holes'); %fill holes

% remove fewer than 30 pixels in binary image
I = bwareaopen(I,200);

se = strel('disk',1); %insert disk

bw = imclose(I,se);

I = imfill(I,'holes');%holes

figure,imshow(I);title('Original Image');% show original binary form B.

% figure,imshow(D);title('Binary Image'); % show binary 2

figure, imshow(I), title('Original Image'); % show proccess
text(size(I,2),size(I,1)+15, ...
    '..', ...
    'FontSize',7,'HorizontalAlignment','right');
text(size(I,2),size(I,1)+25, ....
    '..', ...
    'FontSize',7,'HorizontalAlignment','right');

[B, L] = bwboundaries(I,'holes');

% matrix boundary
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 1)
end

stats = regionprops(L,'Area','Centroid'); % regionprops ( smartest function)
threshold = 1;

% Skin mole segmentation.( very primiitve, need to me improved )

for k = 1:length(B)
  boundary = B{k};
  delta_sq = diff(boundary).^2;
  perimeter = sum(sqrt(sum(delta_sq,2)));
 area = stats(k).Area;
% caculate the roundness
  Roundness = 4*pi*area/perimeter^2;
  display(Roundness);
  % results
  metric_string = sprintf('%2.2f',Roundness);
  %Calculate the diamter
Diameter = sqrt(4*area/pi);
display(Diameter);
 diameter = sprintf('%2.2f',Diameter);
  if Roundness < threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
  end
 text(boundary(1,2)-60,boundary(1,1)+20,metric_string,'Color','r',...
       'FontSize',14,'FontWeight','bold');
   
  text(boundary(1,2)-60,boundary(1,1)+2,diameter,'Color','b',...
       'FontSize',14,'FontWeight','bold');

end

% Skin mole segmentation.( very primitve, need to me improved )

title(['Metric 60> indicate that ',...  
       'mole is not normal']);
%sobel
[~, threshold] = edge(I, 'sobel');
fudgeFactor = .5;
BWs = edge(I,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('Binary  Mask');
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('Mask');
BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('No Holes');
BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('Border Removed');
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal), title('Final Binary Mask');
BWoutline = bwperim(BWfinal);
Segout = A;
Segout(BWoutline) = 255;
% figure, imshow(Segout), title('Final Image');


% Skin mole segmentation.( very primitve, need to me improved )





end

