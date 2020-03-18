function model = modelAffine(data)
N=size(data,1);
Q=data(:,1:2);
P=data(:,3:4);
%truevalue which Pt=A*Qt
Qt = [Q';ones(1,N)];
Pt = [P';ones(1,N)];
premodel=pinv(Qt')*Pt';

model=premodel';
model(3,:)=[0 0 1];

model*Qt-Pt

