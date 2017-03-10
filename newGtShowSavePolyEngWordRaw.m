% newGtShowSavePolyEngWordRaw
%%
SAVEFIG = 0; %0, 1

%%
testGtBase = fullfile('newGtRaw', 'txt', 'polyEnglishWord');
testGtDir = fullfile(testGtBase, 'all');
gtGtBase = fullfile('newGtRaw', 'txt', 'polyEngChiTextline');
gtGtDir = fullfile(gtGtBase, 'all');
imgDir = fullfile('img', 'all');
destFigDir = fullfile('newGtRaw', 'figure', 'polyEnglishWord'); 
mkdir(destFigDir);
% show each image and testGt, gtGt
imgFiles = dir(fullfile(imgDir, '*.jpg'));
nImg = numel(imgFiles);
for i = 1:nImg
    % load gtGtPoly and testGtPoly
    imgRawName = imgFiles(i).name;
    fprintf('%d:%s\n', i, imgRawName);
    gtGtFileName = fullfile(gtGtDir, [imgRawName(1:end-3), 'txt']);
    tesGtFileName = fullfile(testGtDir, [imgRawName, '.txt']);
    if exist(gtGtFileName, 'file')
        gtGtPoly = importdata(gtGtFileName);
    end
    if exist(tesGtFileName, 'file')
        testGtData = importdata(tesGtFileName);
        if ~isempty(testGtData)
            testGtPoly = testGtData.data;
        else
            testGtPoly = [];
        end
    else
        testGtPoly = [];
    end
    % show 
    image = imread(fullfile(imgDir, imgRawName));
    imshow(image);
    displayPoly(gtGtPoly, 'r');
    displayPoly(testGtPoly, 'g');
    if SAVEFIG
        saveas(gcf, fullfile(destFigDir, imgRawName));
    end
end