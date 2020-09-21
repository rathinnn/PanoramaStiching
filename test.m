%close all
clear all
saveFileName="zeltron.png";
I1=imread("Rainier1.png");
%I2=imread("Rainier2.png");
%I1=imhistmatch(I1,I2);

I11=single(rgb2gray(I1));

%I11=single(I1);
I2=imread("Rainier2.png");
I22=single(rgb2gray(I2));

%I22=single(I2);
[f1,d1] = vl_sift(I11) ;

[f2,d2] = vl_sift(I22) ;
M = SIFTbruteMatcher(double(d1'), double(d2'), 0.7);
T= RANSAC(double(f1(1:2,:)'), double(f2(1:2,:)'), M,200,30,0.3*size(M,1));
 Stitch(I1,I2, T, saveFileName);
 imshow(imread(saveFileName));
