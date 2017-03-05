% makePolyGtTxtDemo
% x1, y1, x2, y2, x3, y3, x4, y4, transcription
% testShowDemo
CASE = 'train';
destDataBase = '/home/lili/datasets/MSRATD500Poly';
destGtDir = fullfile(destDataBase, 'gt', CASE, 'txt', 'poly');
mkdir(destGtDir);

% dirs
imgDir = fullfile(destDataBase, 'img', CASE);
sourceGtDir = fullfile(destDataBase, 'raw', 'img', CASE);

% read image, show gt
imgFiles = dir(fullfile(imgDir,'*.jpg'));
nImg = numel(imgFiles);
for i = 1:nImg
%     if i < 103
%         continue;
%     end
    rawName = imgFiles(i).name;
    fprintf('%d:%s\n', i, rawName);
    imageName = fullfile(imgDir, rawName);
   
    %image = imread(imageName);
    
    gtName = fullfile(sourceGtDir, [rawName(1:end-3), 'gt']);
    gtData = importdata(gtName);
    if ~isempty(gtData);
        flags = gtData(:, 2); % 0-easy, 1-hard
        goodBoxes = gtData(flags < 1, 3:7); % x, y, w, h, theta
        badBoxes = gtData(flags > 0, 3:7);
        allBoxes = gtData(:, 3:7);
    else
        goodBoxes = [];
        badBoxes = [];
        allBoxes = [];
    end
    
    %% change from anglebox(x, y, w, h, theta) to 
    % poly(x1, y1, x2, y2, x3, y3, x4, y4)
    polys = fromAngleBoxToPoly(goodBoxes);
    
    %% write to gt file
    destGtFile = fullfile(destGtDir, [rawName(1:end-3), 'txt']);
    fp = fopen(destGtFile, 'wt');
    nPoly = size(polys, 1);
    for j = 1:nPoly
        fprintf(fp, '%d, %d, %d, %d, %d, %d, %d, %d\n', polys(j,:));
    end
    fclose(fp);
    %% display image and poly
%     image = imread(imageName);
%     imshow(image);
%     displayPoly(polys);
    %displayBoxAndTag(word);
end