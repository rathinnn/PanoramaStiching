clc
clear all
X=10*rand(100,1);
Y=X+1;
orgTform=[4 5;7 15];
Q=[X Y];
P=([X  Y]*orgTform);


P=P+randn(100,1);

%[I] = find((P(:,1))>60);
I=randperm(100);
I=I(1:20);
P(I,2)=P(I,2)*4.*randn(length(I),1);





[modelRANSAC ,modelt,inliers,error] = ransac([Q P],2,1000,90,0.8);
%model=fitFcn([Q P]);
scatter(P(:,1),P(:,2))
hold on

scatter(inliers(:,3),inliers(:,4))
hold off


modelRANSAC
modelt




