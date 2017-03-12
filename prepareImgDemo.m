% prepareImgDemo

sourceImgBase = '/home/lili/datasets/MSRATD500/raw/img';
subDirs = {'train', 'test'};
destBase = '/home/lili/datasets/MSRATD500';
nSub = length(subDirs);

for i = 1:nSub
    sourceImgDir = fullfile(sourceImgBase, subDirs{i});   
    destImgDir = fullfile(destBase, 'img', subDirs{i});
    imgFiles = dir(fullfile(sourceImgDir, '*.JPG'));
    nImg = numel(imgFiles);
    % make new dir
    mkdir(destImgDir);
   
    for j = 1:nImg
        imgBase = imgFiles(j).name;
        fprintf('%s:%d:%s\n', subDirs{i}, j, imgBase);
        sourceImgName = fullfile(sourceImgDir, imgBase);
        destImgName= fullfile(destImgDir, [imgBase(1:end-3), 'jpg']);       
        % copy image files
        copyfile(sourceImgName, destImgName);   
    end
    
end