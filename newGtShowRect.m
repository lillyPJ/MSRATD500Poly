%newGtShowRect
chooseDir = 'polyEnglishWordRect';
mode = 'error';

testGtDir = fullfile('newGtRaw/txt', chooseDir, mode);
imgDir = fullfile('img', 'all');
figImgDir = fullfile('newGtRaw/figure', chooseDir, mode);

testGtFiles = dir(fullfile(testGtDir, '*.txt'));
nTest = numel(testGtFiles);
for i = 1: nTest
    testGtFileRawName = testGtFiles(i).name;
    fprintf('%d:%s\n', i, testGtFileRawName);
    
    testGtFile = fullfile(testGtDir, testGtFileRawName);
    testGtData = importdata(testGtFile);
    testGt = testGtData.data;
    imgFile = fullfile(imgDir, testGtFileRawName(1:end-4));
    oriImage = imread(imgFile);
    [imgH, imgW, D] = size(oriImage);
    
    imshow(oriImage);
    
    newGt = testGt;

    deltaX = 70;
    deltaY = 30;
    scaleX = 1060/imgW;
    scaleY = 800/imgH;
    
    newGt(:, 1:2:8) = (newGt(:, 1:2:8) - deltaX)./scaleX;
    newGt(:, 2:2:8) = (newGt(:, 2:2:8) - deltaY)./scaleY;
    %     newGt(:, 1:2:8) = newGt(:, 1:2:8).*(imgW/imgWFig);
    %     newGt(:, 2:2:8) = newGt(:, 2:2:8).*(imgH/imgHFig);
    
    %         newGt(:, 1:2:8) = newGt(:, 1:2:8).*1.5102;
    %     newGt(:, 2:2:8) = newGt(:, 2:2:8).*1.5377;
    displayPoly(newGt, 'b');
    
end