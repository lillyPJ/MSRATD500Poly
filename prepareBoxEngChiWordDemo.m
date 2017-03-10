% prepareBoxEngChiWordDemo
% input-eng: XXX.jpg---[x1,y1,x2,y2]-box
% input-chi: XXX.jpg---[x1,y1,x2,y2]-box
% output: XXX.jpg---[x1,y1,x2,y2]-box

CASE = 'train';
destGtBase = '/home/lili/datasets/MSRATD500Poly/gt/';
sourceEngGtDir = fullfile('newGt', 'txt', 'boxEnglishWord', CASE);
sourceChiGtDir = fullfile('newGt', 'txt', 'boxChineseWord', CASE);
destEngChiGtDir = fullfile(destGtBase, CASE, 'txt', 'boxWord');


gtFiles = dir(fullfile(sourceEngGtDir, '*.txt'));
nGt = numel(gtFiles);
for i = 1:nGt
    sourceEngRawName = gtFiles(i).name;
    sourceEngFiles = fullfile(sourceEngGtDir, sourceEngRawName);
    sourceChiFiles = fullfile(sourceChiGtDir, sourceEngRawName);
    destEngChiFiles = fullfile(destEngChiGtDir, sourceEngRawName);
    sourceEngData = importdata(sourceEngFiles);
    sourceChiData = importdata(sourceChiFiles);
    destData = [sourceEngData; sourceChiData];
    if ~isempty(destData)
        nData = length(destData);
        
    end
    
    
    
end

