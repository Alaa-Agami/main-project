% �Զ��궨��Դ���򣬵���Ҫ�ֶ������������ķ�������

im1 = imread('11.bmp'); im1 = rgb2gray(im1);
im2 = imread('22.bmp'); im2 = rgb2gray(im2);
im3 = imread('33.bmp'); im3 = rgb2gray(im3);

% ������������ı��Դ�����������3������ͼ���е�λ��
p1 = [270, 120];
p2 = [370, 245];
p3 = [255, 295];

% P��ķ��߷���
n1 = [0;2;1];   %n1 = n1/norm(n1);
n2 = [1;0;1.3]; %n2 = n2/norm(n2);
n3 = [0;0;1];   %n3 = n3/norm(n3);

% ʽ11.24��P204����Դ����s������Լ������
I1 = [im1(p1(1),p1(2));im1(p2(1),p2(2));im1(p3(1),p3(2))];
I2 = [im2(p1(1),p1(2));im2(p2(1),p2(2));im2(p3(1),p3(2))];
I3 = [im3(p1(1),p1(2));im3(p2(1),p2(2));im3(p3(1),p3(2))];

% ���11.23����ߵ�KdN
s1 = inv([n1';n2';n3'])*double(I1);
s2 = inv([n1';n2';n3'])*double(I2);
s3 = inv([n1';n2';n3'])*double(I3);

sprintf('s1 = [%f;%f;%f];\n', s1(1), s1(2), s1(3))
sprintf('s2 = [%f;%f;%f];\n', s2(1), s2(2), s2(3))
sprintf('s3 = [%f;%f;%f];\n', s3(1), s3(2), s3(3))