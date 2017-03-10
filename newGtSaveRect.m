% newGtSaveRect

chooseDir = 'boxChineseWordRect';

mode = 'error'; %chinese/error
% source gt
testGtDir = fullfile('newGtRaw/txt', chooseDir, mode);
imgDir = fullfile('img', 'all');
testGtFiles = dir(fullfile(testGtDir, '*.txt'));
nTest = numel(testGtFiles);
% dest gt
destGtDir = fullfile('newGtRaw/txt', chooseDir(1:end-4));
% each all files
for i = 1: nTest
    testGtFileRawName = testGtFiles(i).name;
    fprintf('%d:%s\n', i, testGtFileRawName);
    
    %% load gt
    testGtFile = fullfile(testGtDir, testGtFileRawName);
    testGtData = importdata(testGtFile);
    testGt = testGtData.data;
    imgFile = fullfile(imgDir, testGtFileRawName(1:end-4));
    oriImage = imread(imgFile);
    [imgH, imgW, D] = size(oriImage);
    
    %% change Gt
    newGt = testGt;
    deltaX = 70;
    deltaY = 30;
    scaleX = 1060/imgW;
    scaleY = 800/imgH;
    newGt(:, 1:2:8) = (newGt(:, 1:2:8) - deltaX)./scaleX;
    newGt(:, 2:2:8) = (newGt(:, 2:2:8) - deltaY)./scaleY;
    %% show
%     imshow(oriImage);
%     displayPoly(newGt, 'b');
    %% save result
    destGtFile = fullfile(destGtDir, 'all', testGtFileRawName);
    % --mode = 'error'
    if strcmp(mode, 'error')
        fp = fopen(destGtFile, 'wt');
        nGt = size(newGt, 1);
        for j = 1:nGt
            fprintf(fp, '%s %d %d %d %d %d %d %d %d\n', testGtFileRawName(1:end-4), ...
                newGt(j,:));
        end
        fclose(fp);
    else if strcmp(mode, 'miss')
                fp = fopen(destGtFile, 'at');
        nGt = size(newGt, 1);
        for j = 1:nGt
            fprintf(fp, '%s %d %d %d %d %d %d %d %d\n', testGtFileRawName(1:end-4), ...
                newGt(j,:));
        end
        fclose(fp);    
        end
    end
end