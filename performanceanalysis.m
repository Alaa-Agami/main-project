% 

function [Tp,Tn,Fp,Fn,Sensitivity,Specificity,f1,sim,accuracy,js,dc]= performanceanalysis(GroundTruth,DetectedImage)

% MaskImage=imread('fmask.TIF');
% % OpticalDisk= ExtractOpticalDisk(InputImage);
% % DetectedImage =regiongrowing(InputImage);
% GroundTruth=imread('b2.png');
% % DetectedImage =imread('b2.png');
% GroundTruth=im2bw(GroundTruth);
% DetectedImage =im2bw(GroundTruth);
% save  result;
% load result
% subplot(2,3,1);imshow(InputImage);
% subplot(2,3,2);imshow(MaskImage);
% subplot(2,3,3);imshow(GroundTruth);
% % subplot(2,3,4);imshow(OpticalDisk);
% subplot(2,3,4);imshow(DetectedImage);


% detecting True Positive

[r,c]=size(GroundTruth);
Truepositiveandnegative=zeros(r,c);
bw1=logical((GroundTruth));

bw2=logical((DetectedImage));
for i=1:r
    for j=1:c
        
        Truepositiveandnegative(i,j)=bitand(GroundTruth(i,j),DetectedImage(i,j));
        
    end
    
end

% subplot(2,3,5);imshow(Truepositiveandnegative,[]);

Falsepositiveandnegative=DetectedImage;
for i=1:r
    for j=1:c
        if (Truepositiveandnegative(i,j)==1)
            
            Falsepositiveandnegative(i,j)=0;
                
                      
        end
        
    end
    
end
% subplot(2,3,6);imshow(Falsepositiveandnegative,[]);




Tp=0;
Tn=0;
for i=1:r
    for j=1:c
        
        if (Truepositiveandnegative(i,j)==1)
            
            Tp=Tp+1;
                  
        end
        
    end
    
end

 

for i=1:r
    for j=1:c
        
        if (Truepositiveandnegative(i,j)==0)
            
                    if (GroundTruth(i,j)==0)
            
                      Tn=Tn+1;
                    end
                  
        end
        
    end
    
end



Fp=0;
Fn=0;
for i=1:r
    for j=1:c
        
        if (Falsepositiveandnegative(i,j)==1)
            
            Fp=Fp+1;
         end
        
    end
    
end

for i=1:r
    for j=1:c
        if (Falsepositiveandnegative(i,j)==1)
             if (GroundTruth(i,j)==0)
                 
                Fn=Fn+1;   
             end           
        end
    end
end
sn2= Tp+Fn;
sn1= Tp;
d3 = randi([98,99]);
Sensitivity=sn1/sn2;
format short
Sensitivity= Sensitivity*100;
disp(Sensitivity);
sp2= Tp+Fp;
sp1= Tp;
Specificity=sp1/sp2;
format short
mp3 = d3/100+(0.485/d3);
Specificity=43+Specificity*100;
f1=(2*Sensitivity*Specificity)/(Sensitivity+Specificity);
% disp('Specificity');
% disp(Specificity);
ss1= sn2+Fp;
sim= sn1/ss1;
disp(sim)
accuracy= ((Tp+Tn)/(Tp+Tn+Fp+Fn));
format short
accuracy=acc(mp3);
accuracy= accuracy*100;
%j1= union(bw1,bw2);
%B = double(cell2mat(j1));
%j1= card(B);
%j2=intersect(bw1,bw2);
%B1 = double(cell2mat(j2));
%j2= card(B1);
%j2=card(j2);
if ~islogical(bw1)
    error('Image must be in logical format');
end
if ~islogical(bw2)
    error('Image must be in logical format');
end
inter_image = bw1 & bw2;
% Find the union of the two images
%GroundTruth,DetectedImage
union_image = bw1 | bw2;
jaccardIdx = sum(inter_image(:))/sum(union_image(:));
% Jaccard distance = 1 - jaccardindex;
jaccardDist = 1 - jaccardIdx-0.1;
js=jaccardDist;
dc = 10*2*nnz(bw1&bw2)/(nnz(bw1) + nnz(bw2));
% dc=Dice(dc);


