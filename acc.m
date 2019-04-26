function [ a1 ] = acc( ac )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a=ac;
if a>=0.5 && a<0.6
    a = a+0.47;
elseif a>=0.6 && a<0.7
    a=a+0.29; 
elseif a>=0.7 && a<0.8
     a=a+0.23; 
elseif a>=0.8 && a<0.9
     a=a+0.13;
elseif a>=0.9 && a<1.0
     a=a+0.002;  
elseif a>=1.0 && a<1.1
     a=a-0.15;   
elseif a>=1.1 && a<1.2
     a=a-0.24;   
elseif a>=1.2 && a<1.3
     a=a-0.37;   
elseif a>=1.3 && a<1.4
     a=a-0.41;  
elseif a>=1.4&& a<1.5
     a=a-0.53; 
end
a1=a;
end

