% testGetPolyFromBoxDemo: normal rect box
imgDir = './img/train';

imgFiles = dir(fullfile(imgDir, '*.JPG'));
nImg = numel(imgFiles);
for i = 1:nImg
%     if i < 14
%         continue;
%     end
    imgBaseName = imgFiles(i).name; 
    %imgBaseName = 'IMG_1805.JPG';
    imageName = fullfile(imgDir, imgBaseName);
    image = imread(imageName);
    gtFileName = fullfile(imgDir, [imgBaseName(1:end-3), 'gt']);
    [box, polyAngle] = getRectBoxFromGt(gtFileName);
    imshow(image);
    displayBox(box, 'r');
    %hold on;
    %plot(box(2,1)+box(2,3)/2, box(2,2)+box(2,4)/2, 'yo');
    angleBox = getPolyFromBox(box, polyAngle);
    
    imshow(image);
    
    displayAngleBox(angleBox);
    fprintf('%d:%s\n', i, imgBaseName);
end