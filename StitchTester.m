
clc; close all; clc;


imgList = dir('../data/goldengate-*.png');

saveFileName = 'melakwalake.jpg';


addpath('KeypointDetect');

IMAGES = cell(1, length(imgList));
for i = 1 : length(imgList),
    IMAGES{i} = imread(['../data/' imgList(i).name]);

    if max(size(IMAGES{i})) > 1000 || length(imgList) > 10,
        IMAGES{i} = imresize(IMAGES{i}, 0.6);
    end
end
disp('Images loaded. Beginning feature detection...');

DESCRIPTOR = cell(1, length(imgList));
POINT_IN_IMG = cell(1, length(imgList));
for i = 1 : length(imgList),
	%I = single(rgb2gray(IMAGES{i}));
    I=single(IMAGES{i});
	[f,d] = vl_sift(I) ;
	POINT_IN_IMG{i} = double(f(1:2,:)');
	DESCRIPTOR{i} = double(d');
end


TRANSFORM = cell(1, length(imgList)-1);
for i = 1 : (length(imgList)-1),
    disp(['fitting transformation from ' num2str(i) ' to ' num2str(i+1)])
    M = SIFTSimpleMatcher(DESCRIPTOR{i}, DESCRIPTOR{i+1}, 0.7);
    TRANSFORM{i} = RANSACFit(POINT_IN_IMG{i}, POINT_IN_IMG{i+1}, M,3,0.1,0.3*size(M,1));
end


disp('Stitching images...')
MultipleStitch(IMAGES, TRANSFORM, saveFileName);
disp(['The completed file has been saved as ' saveFileName]);
imshow(imread(saveFileName));
