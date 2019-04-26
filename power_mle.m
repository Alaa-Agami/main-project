function loglik = power_mle(a)
global n t x
   p=a(1,1)*t.^(-a(2,1));
   p=(p < ones(6,1)).*p+(p >= ones(6,1))*.999999;
   loglik=(-1)*(x.*log(p)+(n-x).*log(1-p));
   loglik=sum(loglik);
   
