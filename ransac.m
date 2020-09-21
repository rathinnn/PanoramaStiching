function H = RANSAC(Points1, Points2, match, Iterations, minNumber, error, inlierratio )


   
    N = size(match, 1);
   
    if ~exist('Iterations', 'var')
        Iterations = 200;
    end
    
    minNumber = max(minNumber,3);
   
    if ~exist('inlierratio', 'var')
        inlierratio = floor(0.7 * N);
    end
    H = eye(3);
    
    
    bestDist = Inf;
    
    
    
    for i = 1 : Iterations
        [part1, part2] = split(match, minNumber);
        tempModel = modelAffine(Points1(part1(:, 1), :), Points2(part1(:, 2), :));
        currenterror = EuclidDist(tempModel, Points1, Points2, part2);
        epsilon = (currenterror <= error);
        if sum(epsilon(:)) + minNumber >= inlierratio
            zeta = [part1; part2(epsilon, :)];
            tempModel = modelAffine(Points1(zeta(:, 1), :), Points2(zeta(:, 2), :));
            theta = sum(EuclidDist(tempModel, Points1, Points2, zeta));
            if theta < bestDist
                H = tempModel;
                
                bestDist = theta;
            end
        end
    end

    
end

function dists = EuclidDist(H, pt1, pt2, match)

    
    [M , ~] = size(match);
    Points1 = [pt1(match(:, 1),:), ones(M,1)]*H';
    Points2 = [pt2(match(:, 2),:), ones(M,1)];
    dists = sqrt(sum((Points2 - Points1).^2, 2));


    
end

function [D1, D2] = split(match, splitSize)
    idx = randperm(size(match, 1));
    D1 = match(idx(1:splitSize), :);
    D2 = match(idx(splitSize+1:end), :);
end















