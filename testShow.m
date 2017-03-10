%testShow
imgDir = '/home/lili/Desktop/english/figure/error';
imgFiles = dir(fullfile(imgDir, '*.jpg'));
nImg = numel(imgFiles);

i = 1;
image = imread(fullfile(imgDir, imgFiles(i).name));
imshow(image);
