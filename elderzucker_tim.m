function mrsmap2 = elderzucker_tim(I)
im = I;
im = im(:,:,1);

%Some variables
sn = 3; %image noise [sigma]
alphap = 2e-7; %2e-7

%Apply white noise sn to image (optional)
%im = imnoise(im,'gaussian',0,(sn/255)^2);
imd=double(im);

sigma1 = [8 4 2 1 0.5]; %Scale space octaves for 1st deriv
sigma2 = sigma1;

%Preallocate some matrices
mrsmap1=ones(size(im))*4;
mrsmap2=ones(size(im))*4;
edge2nd=zeros(size(im));
edge3rd=zeros(size(im));

%Make steerable gaussian 1st order derivative filters
for i=1:length(sigma1)
    %First derivative part
    
    %Create normal gaussian filter kernel
    h = fspecial('gaussian', round(10*sigma1(i)), sigma1(i));
    %Create gaussian 1st order gradient in X and Y direction
    [g1x,g1y] = gradient(h);
    %Apply the filters on the image
    r1x=imfilter(imd,g1x,'replicate');
    r1y=imfilter(imd,g1y,'replicate');
    thetam=atan2(r1y, r1x);
    r1theta=cos(thetam).*r1x + sin(thetam).*r1y;
    r1theta_or=r1theta;
    %Compute critical value
    g1theta2=1/(2*sqrt(2*pi)*sigma1(i)^2);
    s1=g1theta2*sn;
    c1=s1*sqrt(-2*log(alphap));
    %Make the binary 1st deriv reliable map
    reliable1=(abs(r1theta) >= c1);

    %Put into the Minimum Reliable Scale map (1st)
    mrsmap1(reliable1)=sigma1(i);
    %Apply threshold on r1theta and thetam
    thetam=thetam.*reliable1;
    r1theta=r1theta.*reliable1;
    
    
    %Second derivative part
    
    %Make 2nd order gaussian filter kernels
%    [g2x,g2xy] = gradient(gradient(h));
%    g2y=rot90(g2x);
    %Apply 2nd order gaussian filter kernels to image
%    r2x=imfilter(imd,g2x,'replicate');
%    r2y=imfilter(imd,g2y,'replicate');
%    r2xy=imfilter(imd,g2xy,'replicate');
    [r2x,r2y] = gradient(r1theta_or);
    
    %Compute 2nd derivative in maginitude direction
    r2theta=cos(thetam).*r2x + sin(thetam).*r2y;
    r2theta_or=r2theta;
    %r2theta =(cos(thetam).^2 .* r2x)+(sin(thetam).^2 .* r2y)...
    %    -(2.*cos(thetam).*sin(thetam).*r2xy);
    g22=1/(4*sqrt(pi/3)*sigma2(i)^3);
    s2=g22*sn;
    c2=sqrt(2)*s2*erfinv(1-alphap); %paper says (alpha)???
    %Make the binary 2nd deriv reliable map
    reliable2=(abs(r2theta) >= c2);
    %Put into the Minimum Reliable Scale map (2nd)
    mrsmap2(reliable2)=sigma2(i);
    %Apply threshold on r2theta
    r2theta=r2theta.*reliable2;
    %Now remove the new lower sigma part for filling in
    edge2nd=edge2nd.*(1-reliable1.*reliable2);
        
    %Locate the edges at zero crossings in 
    % binary image (discrete for simplicity)
    edge2nd=edge2nd+edge(r2theta>0,'canny')*sigma1(i);
    
    %LOOK FOR ZERO CROSSINGS in [3x3] window
%     for x=1:(size(im,2)-2);
%         for y=1:(size(im,1)-2);
%             %[3x3] window
%             imw=r2theta(y:y+2,x:x+2);
%             %Check for sign changes within window
%             sp=sum(sum(imw>=0));
%             sm=sum(sum(imw<=0));
%             %Apply to edgemap
%             if (sp~=9 && sm~=9)
%                 edge2nd(y,x)=sigma1(i);
%             end
%         end
%     end
    
    
    
    
    
    
    %Now remove the new lower sigma part for filling in
    edge3rd=edge3rd.*(1-reliable1.*reliable2);
    
    %Make the third derivative
    [r3x,r3y]=gradient(r2theta_or);
    r3theta=cos(thetam).*r3x + sin(thetam).*r3y;
    edge3rd=edge3rd+edge(r3theta>0,'canny')*sigma1(i);
    %Now ignore the edges at faulty locations
    %edge3rd=edge3rd.*imerode(reliable1,ones(10));
   
    
    %Now, for every point in edge2nd, run along the direction
    % of the gradient (thetam) and find the first occurancy of
    % a zero in the third derivative map.
    
  
    


    imagesc(r2theta)
    colormap gray

     figure
     hold on
     plot([1:26.6/length(r3x):26.6],'--r')
     hold off, grid on
     legend('estimated','actual')
     ylabel('Blur scale (px)')
     xlabel('Arclength(px)')
     title(['\sigma=' num2str(sn)])
 pause(2)
  figure
  imagesc(r1theta)
  colormap gray
  figure
%  plot(r2theta(:,550))
 % pause(1)
end

figure
subplot(2,3,1), imshow(im)
title('original')
subplot(2,3,2), imagesc(sqrt(mrsmap1))
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[]),axis image
colormap hot
title('mrs map 1st deriv')
imwrite(sqrt(mrsmap1),'Process_Image\map1.jpg','jpg');
subplot(2,3,3), imagesc(sqrt(mrsmap2))
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[]),axis image
colormap hot
title('mrs map 2nd deriv')
imwrite(sqrt(mrsmap2),'Process_Image\map2.jpg','jpg');
subplot(2,3,6), imagesc(mrsmap2==0.5)
title('\sigma=0.5')
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[]),axis image
subplot(2,3,5), imagesc(mrsmap2==1)
title('\sigma=1')
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[]),axis image
subplot(2,3,4), imagesc(mrsmap2==8)
title('\sigma=8')
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[]),axis image


subplot(1,3,1), [f1]=imagesc(r2theta,[-1 1]);
axis image, colormap gray
title('2nd derivative map')
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[])
subplot(1,3,2), [f2]=imagesc(r3theta,[-0.01 0.01]);
axis image, colormap gray
title('3rd derivative map')
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[])

imrgb(:,:,1)=im+uint8(edge2nd*100);
imrgb(:,:,2)=im+uint8(edge3rd*100);
imrgb(:,:,3)=im;
subplot(1,3,3)
imshow(imrgb)
title('2nd and 3rd order zero crossing overlay')

figure
surf(mrsmap2,'edgecolor','none')
colormap cool
camlight