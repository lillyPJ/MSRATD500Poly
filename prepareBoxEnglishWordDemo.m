%prepareBoxEnglishWordDemo
% input: XXX.jpg.txt---XXX.jpg, [x1,y1,x2,y2,x3,y3,x4,y4]-poly
% output: XXX.jpg---[x1,y1,x2,y2]-box
CASE = 'train';
DISPLAY = 0;

sourceGtDir = fullfile('newGtRaw', 'txt', 'polyEnglishWord', 'all');
destGtDir = fullfile('newGt', 'txt', 'boxEnglishWord', CASE);

mkdir(destGtDir);
imgDir = fullfile('img', CASE);
%
imgFiles = dir(fullfile(imgDir, '*.JPG'));
nImg = numel(imgFiles);
for i = 1:nImg
    imgRawName = imgFiles(i).name;
    fprintf('%d:%s\n', i, imgRawName);
    % load gt
    sourceGtFileName = fullfile(sourceGtDir, [imgRawName(1:end-3), 'jpg.txt']);
    destGtFileName = fullfile(destGtDir, [imgRawName(1:end-3), 'txt']);
    box = [];
    if exist(sourceGtFileName, 'file')
        sourceGtData = importdata(sourceGtFileName);
        sourceGt = sourceGtData.data;
        % poly -> box
        if ~isempty(sourceGt)
            xmin = min(sourceGt(:, 1:2:8), [], 2);
            xmax = max(sourceGt(:, 1:2:8), [], 2);
            ymin = min(sourceGt(:, 2:2:8), [], 2);
            ymax = max(sourceGt(:, 2:2:8), [], 2);
            box = round([xmin, ymin, xmax, ymax]);
        end
    end
    if DISPLAY
        image = imread(fullfile(imgDir, imgRawName));
        imshow(image);
        displayBoxV2(box);
    end
    % write to destGt
    fp = fopen(destGtFileName, 'wt');
    if ~isempty(box)
        fprintf(fp, '%d, %d, %d, %d, "1"\n', box');
    end
    fclose(fp);
    
end
