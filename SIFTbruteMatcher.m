function match = SIFTbruteMatcher(d1, d2, thresh)

   

    match = [];
[N1 , ~] = size(d1);
[N2 , ~] = size(d2);

for i = 1 : N1 
    temp = repmat(d1(i,:), N2, 1);   
    d = sqrt(sum((temp - d2).^2, 2));    
    
    [sorted, idx] = sort(d);                 
    if sorted(1) < (sorted(2) * thresh)     
        match = [ match ; [i, idx(1)] ]; 
    end    
end


end
