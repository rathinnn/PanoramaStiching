function H = modelAffine( Pt1, Pt2 )


    N = size(Pt1,1);
    
    

    P1 = [Pt1';ones(1,N)];
    P2 = [Pt2';ones(1,N)];


    
    

H = (P1'\P2')';

    H(3,:) = [0 0 1];
end
