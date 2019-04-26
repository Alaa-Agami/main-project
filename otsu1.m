function bin_im = mygraythresh(B)

global H Index;

V=reshape(B,[],1);
G=hist(V,0:255);
H=reshape(G,[],1);
Ind=0:255;
Index=reshape(Ind,[],1);
result=zeros(size([1 256]));
for i=0:255
    [wbk,varbk]=calculate(1,i);
    [wfg,varfg]=calculate(i+1,255);
    result(i+1)=(wbk*varbk)+(wfg*varfg);
end
 %Find the minimum value in the array.                  
 [threshold_value,val]=min(result);
  tval=(val-1)/256;
  bin_im=im2bw(B,tval);
  bin_im = ~bin_im;
 
  function [weight,var]=calculate(m,n)
    %Weight Calculation
     weight=sum(H(m:n))/sum(H);
    %Mean Calculation
     value=H(m:n).*Index(m:n);
     total=sum(value);
     mean=total/sum(H(m:n));
     if(isnan(mean)==1)
         mean=0;
     end
    %Variance calculation.
    value2=(Index(m:n)-mean).^2;
     numer=sum(value2.*H(m:n));
     var=numer/sum(H(m:n));
     if(isnan(var)==1)
         var=0;
     end
 end

 end
