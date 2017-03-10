% test
rightDir = '/home/lili/datasets/MSRATD500Poly/raw/newGtRaw/txt/boxChineseWord/all/';
a = importdata(fullfile(rightDir, 'IMG_0728.jpg.txt')); 
goodGt = a.data;

scaleX = (testGt(10, 3)-testGt(10,7) + 0.0)/(goodGt(10,3)-goodGt(10,7));
deltaX = testGt(10,7)-goodGt(10,7)*scaleX;

scaleY = (testGt(10, 2)-testGt(10,6) + 0.0)/(goodGt(10,2)-goodGt(10,6));
deltaY = testGt(10,6)-goodGt(10,6)*scaleY;
