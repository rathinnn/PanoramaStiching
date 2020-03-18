function [bestmodel inlier besterr] = ransac(data,num,iter,threshDist,inlierRatio)
 % data: a mx4 dataset with #n data points
 % num: the minimum number of points. For line fitting problem, num=2
 % iter: the number of iterations
 % threshDist: the threshold of the distances between points and the fitting line
 % inlierRatio: the threshold of the number of inliers 
 
 check=0;
 number = size(data,1); % Total number of points
 bestInNum = 0; % Best fitting line with largest number of inliers
 bestmodel=[];
 besterr=1000000000;
 for i=1:iter
     alsoinliers=[];
 %% Randomly select 2 points
     idx = randperm(number,num); maybeinliers = data(idx,:);
     Q=data(:,1:2); P=data(:,3:4);
 %% Compute the distances between all points with the fitting line 
    remaining=data;
    remaining(idx,:)=[];
    Q_remaining=remaining(:,1:2);
    P_remaining=remaining(:,3:4);
    model=fitFcn(maybeinliers);
    
    pred=model*Q_remaining';
    error=pred'-P_remaining;
    
    error2 = error(:,1).^2+error(:,2).^2;
    trueerror = sqrt(error2);
    
    [I] = find(abs(trueerror)<=threshDist);
    
    alsoinliers=remaining(I,:);
    
     inlierNum = size(alsoinliers,1)+num;
     
     
 %% Compute the inliers with distances smaller than the threshold

 %% Update the number of inliers and fitting model if better model is found     
     
 
    
 
    if inlierNum>=round(inlierRatio*number) 
         
         
         bettermodel=fitFcn([alsoinliers;maybeinliers]);
         
         betterpred=bettermodel*[alsoinliers(:,1:2);maybeinliers(:,1:2)]';
         prerror=betterpred'-[alsoinliers(:,3:4);maybeinliers(:,3:4)];
         
         thiserr=computeError(prerror);
         
         
         check=1;
     if thiserr<besterr
    inlierNum
    bestmodel=bettermodel;
    besterr=thiserr;
    inlier=[alsoinliers;maybeinliers];
    
    end
        
    
    end
    
    
    
     
 end

 if check==0
     fprintf('No RANSAC Fit found')
end