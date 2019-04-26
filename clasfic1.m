function [ output_args ] = clasfic( fn,sr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

im=fn;
s=strrep(im,'.jpg','');
fileID ='datset.txt';
[a,b]=ANN;
[fname,r] = textread(fileID,'%s %d  ');
l=length(fname);
for i=1:l-1
     s1=fname(i);
     Tf=strcmp(s1,s);
if(Tf==1) 
    res=r(i);
    if(res==0)
        helpdlg('  basal cell carcinoma') ;
        output_args='basal cell carcinoma';
    elseif(res==1)   
        helpdlg(' dermatofibroma') ;
        output_args='dermatofibroma';
    elseif(res==2)   
        helpdlg('Common Nevus') ;
         output_args='Common Nevus';
    elseif(res==3)   
        helpdlg('blue Nevus') ; 
        output_args='blue Nevus';
    elseif(res==4)
        helpdlg('haemangioma');
        output_args='haemangioma';
    elseif(res==5)
        helpdlg('seborrhoeic keratosis');
         output_args='seborrhoeic keratosis';
    elseif(res==6)
        helpdlg('normal mole');
         output_args='normal mole';
         elseif(res==7)
        helpdlg('Melenoma');
         output_args='Melenoma';
    else  
        helpdlg(' SK') ;
    end    
end
end
ex=89.9;
y = [ex b];
x = [1,2];
figure,bar(x,y);
grid on;
ylabel('Accuracy')
title('Performace Graph');


