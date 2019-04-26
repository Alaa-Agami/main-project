function yy = expo_lse(a,y)
global t;
   p=a(1,1)*exp(-a(2,1)*t);
   yy=p-y;
   
