% 
%%
SAVEFIG = 1; %0, 1

%%
testGtEngBase = fullfile('newGtRaw', 'txt', 'polyEnglishWord');
testGtEngDir = fullfile(testGtEngBase, 'all');
testGtChiBase = fullfile('newGtRaw', 'txt', 'boxChineseWord');
testGtChiDir = fullfile(testGtChiBase, 'all');

gtGtBase = fullfile('newGtRaw', 'txt', 'polyEngChiTextline');
gtGtDir = fullfile(gtGtBase, 'all');
imgDir = fullfile('img', 'all');
destFigDir = fullfile('newGtRaw', 'figure', 'gtEnglishChineseRaw'); 
mkdir(destFigDir);
% show each image and testGt, gtGt
imgFiles = dir(fullfile(imgDir, '*.jpg'));
nImg = numel(imgFiles);
for i = 1:nImg
    % load gtGtPoly and testGtPoly
    imgRawName = imgFiles(i).name;
    fprintf('%d:%s\n', i, imgRawName);
    gtGtFileName = fullfile(gtGtDir, [imgRawName(1:end-3), 'txt']);
    testGtEngFileName = fullfile(testGtEngDir, [imgRawName, '.txt']);
    testGtChiFileName = fullfile(testGtChiDir, [imgRawName, '.txt']);
    
    if exist(gtGtFileName, 'file')
        gtGtPoly = importdata(gtGtFileName);
    end
    if exist(testGtEngFileName, 'file')
        testGtData = importdata(testGtEngFileName);
        if ~isempty(testGtData)
            testGtEngPoly = testGtData.data;
        else
            testGtEngPoly = [];
        end
    else
        testGtEngPoly = [];
    end
    if exist(testGtChiFileName, 'file')
        testGtData = importdata(testGtChiFileName);
        if ~isempty(testGtData)
            testGtChiPoly = testGtData.data;
        else
            testGtChiPoly = [];
        end
    else
        testGtChiPoly = [];
    end
    % show 
    image = imread(fullfile(imgDir, imgRawName));
    imshow(image);
    displayPoly(gtGtPoly, 'r');
    displayPoly(testGtEngPoly, 'g');
    displayPoly(testGtChiPoly, 'b');
    if SAVEFIG
        saveas(gcf, fullfile(destFigDir, imgRawName));
    end
end