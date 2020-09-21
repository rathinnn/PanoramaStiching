function Panorama = Stitch(img1, img2, H, fileName)

[nrows, ncols, ~] = size(img1);
exmargin = zeros(2,2);
exmargin(1,:) = Inf;
exmargin(2,:) = -Inf;
A = maketform('affine', H');
    margin = findbounds(A, [0, 0; 2*nrows, 2*ncols]);
    exmargin(1,:) = min(exmargin(1,:), margin(1,:));
    exmargin(2,:) = max(exmargin(2,:), margin(2,:));
    
A = maketform('affine', eye(3));
    margin = findbounds(A, [0, 0; 2*nrows, 2*ncols]);
    exmargin(1,:) = min(exmargin(1,:), margin(1,:));
    exmargin(2,:) = max(exmargin(2,:), margin(2,:));
    
XLIMIT = round(exmargin(:, 1)');
YLIMIT = round(exmargin(:, 2)');

Panorama = imtransform( im2double(img2), maketform('affine', eye(3)), 'bilinear', ...
                    'XData', XLIMIT, 'YData', YLIMIT, ...
                    'FillValues', NaN, 'XYScale', 1);

AddOn = imtransform(im2double(img1), maketform('affine', H'), 'bilinear', ...
                    'XData', XLIMIT, 'YData', YLIMIT, ...
                    'FillValues', NaN, 'XYScale', 1);
                
Pano2=Panorama;
overlay1 = ~isnan(Panorama(:,:,1));
overlay2 = ~isnan(AddOn(:,:,1));
crossoverlay = overlay2 & (~overlay1);
blendoverlay = overlay2 & (overlay1);
figure;
[i,j] = find(blendoverlay==1);
m=[i j];
for c = 1 : size(Panorama,3)
    currentimage = Panorama(:,:,c);
    temporaryimage = AddOn(:,:,c);
    currentimage(crossoverlay) = temporaryimage(crossoverlay);
    Panorama(:,:,c) = currentimage;
end

for c=1:size(Panorama,3)
for row = 1:size(i)
   
    r=m(row,1);
    col=m(row,2);
    d1=col-j(1);
    d2=j(end)-col;
    w=d1/(d1+d2);
    Panorama(r,col,c)=(1-w)*AddOn(r,col,c)+w*Pano2(r,col,c);
end
end

[I, J] = ind2sub([size(Panorama, 1), size(Panorama, 2)], find(~isnan(Panorama(:, :, 1))));
upperBound = max(min(I)-1, 1);
lowerBound = min(max(I)+1, size(Panorama, 1));
leftcrop = max(min(J)-1, 1);
rightcrop = min(max(J)+1, size(Panorama, 2));
Panorama = Panorama(upperBound:lowerBound, leftcrop:rightcrop,:);
imwrite(Panorama, fileName);

end

