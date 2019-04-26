% tut1lse.m (Nov 2001)/LSE/JMP tutorial on MLE
global t x
opts=optimset('DerivativeCheck','off','Display','off','TolX',1e-6,'TolFun',1e-6,...
   'Diagnostics','off','MaxIter',100);

t=[1 3 6 9 12 18]';
y=[.94 .77 .40 .26 .24 .16]';

init_a=rand(2,1);lower_a=0;upper_a=100;
[am1,sse1,resid1,exit1]=lsqnonlin('power_lse',init_a,lower_a,upper_a,opts,y);
[am2,sse2,resid2,exit2]=lsqnonlin('expo_lse',init_a,lower_a,upper_a,opts,y);

r2(1,1)=1-sse1/sum((y-mean(y)).^2);r2(2,1)=1-sse2/sum((y-mean(y)).^2);
sse(1,1)=sse1;sse(2,1)=sse2;
exit(1,1)=exit1;exit(2,1)=exit2;

format long;disp(num2str([am1 am2 r2 sse exit],5));





