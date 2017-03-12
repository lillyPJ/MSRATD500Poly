% preparePolyEngChiTextlineDemo
% input: XXX.jpg---[x1,y1,x2,y2,x3,y3,x4,y4]-poly
% output: XXX.jpg---[x1,y1,x2,y2,x3,y3,x4,y4,"#"]-poly

CASE = 'train';
DISPLAY = 0;

destGtBase = '/home/lili/datasets/MSRATD500';
sourceGtDir = fullfile('newGtRaw', 'txt', 'polyEngChiTextline', 'all');
destGtDir = fullfile(destGtBase, 'gt', CASE, 'txt', 'polyTextline');
mkdir(destGtDir);
imgDir = fullfile(destGtBase, 'img', CASE);
%
imgFiles = dir(fullfile(imgDir, '*.jpg'));
nImg = numel(imgFiles);
for i = 1:nImg
    imgRawName = imgFiles(i).name;
    fprintf('%d:%s\n', i, imgRawName);
    % load gt
    sourceGtFileName = fullfile(sourceGtDir, [imgRawName(1:end-3), 'txt']);
    destGtFileName = fullfile(destGtDir, [imgRawName(1:end-3), 'txt']);
    sourceGt = [];
    if exist(sourceGtFileName, 'file')
        sourceGtData = importdata(sourceGtFileName);
        sourceGt = round(sourceGtData);
    end
    if DISPLAY
        image = imread(fullfile(imgDir, imgRawName));
        imshow(image);
        displayPoly(sourceGt);
    end
    % write to destGt
    fp = fopen(destGtFileName, 'wt');
    if ~isempty(sourceGt)
        fprintf(fp, '%d, %d, %d, %d, %d, %d, %d, %d, "#"\n', sourceGt');
    end
    fclose(fp);
    
end
