function e= computeError(error)
error2 = error(:,1).^2+error(:,2).^2;
trueerror = sqrt(error2);

e=(1/size(trueerror,1))*sum(trueerror);
end