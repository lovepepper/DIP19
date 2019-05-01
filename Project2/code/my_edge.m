function output = my_edge(input, method)
%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores
if strcmp(method, 'Canny')
    %TODO: Canny Method
    output = edge(input, 'approxcanny');
else
    switch method
        case 'Roberts'
            wx = [0, 0, 0; 0, 1, 0; 0, 0, -1];
            wy = [0, 0, 0; 0, 0, 1; 0, -1, 0];
            scale = 6;
        case 'Prewitt'
            wx = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
            wy = [-1, -1, -1; 0, 0, 0; 1, 1, 1];
            scale = 3;
        case 'Sobel'
            wx = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
            wy = [-1, -1, -1; 0, 0, 0; 1, 1, 1];
            scale = 2;
    end
    gx = abs(imfilter(input, wx, 'replicate'));
    gy = abs(imfilter(input, wy, 'replicate'));
    g = gx.^2+ gy.^2;
    %choose the threshold automatically
    cutoff = scale * sum(g(:), 'double') / numel(g);
    output = g > cutoff;
    output = bwmorph(output, 'thin', 10);
end

