function boundary = my_edgelinking(binImage, x, y)
%in this function, you should finish the edge linking utility.
%the input parameters are a matrix of a binary image containing the edge
%information and coordinates of one of the edge points of a obeject
%boundary, you should run this function multiple times to find different
%object boundaries
%the output parameter is a Q-by-2 matrix, where Q is the number of boundary 
%pixels. B holds the row and column coordinates of the boundary pixels.
%you can use different methods to complete the edge linking function
%the better the quality of object boundary and the more the object boundaries, you will get higher scores 
[m, n] = size(binImage);
padded(m + 2, n + 2) = 0;
padded(2 : m + 1, 2 : n + 1) = binImage;

N = circshift(padded, [0, 1]);
S = circshift(padded, [0, -1]);
E = circshift(padded, [-1, 0]); 
W = circshift(padded, [1, 0]); 
boundImg = padded - (padded + N + S + E + W == 5);

totSize = sum(boundImg(:)) + 1;
boundary = zeros(totSize, 2);

entry = [y, x] + 1;
neighborhood = [-1, 0; -1, -1; 0, -1; 1, -1; 1, 0; 1, 1; 0, 1; -1, 1];
exitDir = [7, 7, 1, 1, 3, 3, 5, 5];
for i = 1 : 8
    c = entry + neighborhood(i, :);
    if padded(c(2), c(1)) == 1
        initPos = c;
        initDir = exitDir(i);
        break;
    end
end
boundary(1, :) = initPos;
pos = initPos;
dir = initDir;
curSize = 1;
while true
    for i = circshift(1 : 8, [0, 1 - dir])
        c = pos + neighborhood(i, :);
        if padded(c(2), c(1)) == 1
            pos = c;
            dir = exitDir(i);
            curSize = curSize + 1;
            boundary(curSize, :) = pos;
            break;
        end
    end
    if all(pos == initPos) && (dir == initDir)
        break;
    end
end
boundary = boundary - 1;
boundary = boundary(1 : curSize, :);




