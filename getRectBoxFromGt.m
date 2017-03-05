function [box, polyAngle] = getRectBoxFromGt(gtFileName)
% [input] gtFileName: the name of a gt file(img/test/IMG_0059.gt)
% [output] box(n*4): box(x, y, w, h)
% [output] polyAngle(n*1): polyAngle
gtData = importdata(gtFileName);
if isempty(gtData)
    box = [];
    polyAngle = [];
    return;
end

flags = gtData(:, 2); % 0-easy, 1-hard
oriBox = gtData(:, 3:7); % x, y, w, h, theta
ths = gtData(:, 7);
%% only select those easy
oriBox = oriBox(flags < 1, :);
nGt = size(oriBox, 1);
%% process each box(get the poly, from poly to rect)
box = zeros(nGt, 4);
if nGt > 0
    polyAngle = oriBox(:, 5);
end
for i = 1:nGt
    polyBox = rotateBoxPoly(oriBox(i, 1:4), oriBox(i, 5));
    box(i,:) = fromPolyToRect(polyBox);   
end
end