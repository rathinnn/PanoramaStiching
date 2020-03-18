function [H t]=goodAffine(data)
%data is mby4
m=size(data,1);
Q=data(:,1:2);
P=data(:,3:4);
N=P';
b=N(:);
A=zeros(m*2,6);
j=1;
for i=1:m*2
    
    if mod(i,2) ~= 0
    A(i,:)=[Q(j,1) Q(j,2) 0 0 1 0 ];
    
    
    else
    A(i,:)=[0 0 Q(j,1) Q(j,2) 0 1];
    j=j+1;
    end
end
%Av=b
V=pinv(A)*b;
H=reshape(V,[3,2]);
t=(H(3,:))';
H(3,:)=[];