%光源方向向量
s1 = [-88.100000;18.000000;187.000000]; s1 = s1/norm(s1);
s2 = [-103.200000;7.500000;214.000000]; s2 = s2/norm(s2);
s3 = [-75.300000;9.500000;211.000000]; s3 = s3/norm(s3);

im1 = imread('11.bmp'); im1 = rgb2gray(im1);
im2 = imread('22.bmp'); im2 = rgb2gray(im2);
im3 = imread('33.bmp'); im3 = rgb2gray(im3);

Z = [];
Z(1,1) = 0;
S = [s1';s2';s3'];
eps = 0.001;
for i=1:size(im1,1)-1
    for j=1:size(im1,2)-1
        I = [im1(i,j);im2(i,j);im3(i,j)];
        nn = inv(S)*double(I);						% 式11.23
        nn = nn/norm(nn);									% 归一化
        if j==1
            n1 = -nn(2)/(nn(3)+eps);
        end
        n2 = -nn(1)/(nn(3)+eps);					% 式11.32
        Z(i,j+1) = Z(i,j) + n2;						% 式11.34
    end
    Z(i+1,1) = Z(i,1) + n1;
end
mesh(-Z);