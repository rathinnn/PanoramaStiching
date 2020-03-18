function model=fitFcn(data)

Q=data(:,1:2);
P=data(:,3:4);

model=P'*pinv(Q');


