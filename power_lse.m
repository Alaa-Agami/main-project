function yy = power_lse(a,y)
global t
   p=a(1,1)*t.^(-a(2,1));
   yy=p-y;
   
