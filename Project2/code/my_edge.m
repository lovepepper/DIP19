function output = my_edge(input, method)
%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores
if strcmp(method, 'Canny')
    [m, n] = size(input);
    output = zeros(m, n);
    % Gaussian Smooth Filter
    sigma = 1;
    filterExtent = ceil(4 * sigma);
    x = -filterExtent : filterExtent;
    c = 1 / (sqrt(2 * pi) * sigma);
    gaussKernel = c * exp(-(x .^ 2) / (2 * sigma ^ 2));
    gaussKernel = gaussKernel/sum(gaussKernel);
    derivGaussKernel = gradient(gaussKernel);
    negVals = derivGaussKernel < 0;
    posVals = derivGaussKernel > 0;
    derivGaussKernel(posVals) = derivGaussKernel(posVals)/sum(derivGaussKernel(posVals));
    derivGaussKernel(negVals) = derivGaussKernel(negVals)/abs(sum(derivGaussKernel(negVals)));
    imgSmooth = imfilter(input, gaussKernel, 'conv', 'replicate');
    imgSmooth = imfilter(imgSmooth, gaussKernel, 'conv', 'replicate');
    % Calculate gradients and do normalize
    dx = imfilter(imgSmooth, derivGaussKernel, 'conv', 'replicate');
    dy = imfilter(imgSmooth, derivGaussKernel', 'conv', 'replicate');
    magGrad = hypot(dx, dy);
    magMax = max(magGrad(:));
    if magMax > 0
        magGrad = magGrad / magMax;
    end
    % Select the thresholds automatically
    counts = imhist(magGrad, 64);
    highThresh = find(cumsum(counts) > 0.7 * m * n, 1, 'first') / 18;
    lowThresh = 0.4 * highThresh;
    % Non-Maximum Suppression and Hysteresis Thresholding
    sector = zeros(m, n);
    for r = 1 : m
        for c = 1 : n
            theta = atand(dy(r, c) / dx(r, c));
            if theta >= -22.5 && theta < 22.5
                sector(r, c) = 0;
            elseif theta >= -67.5 && theta < -22.5
                sector(r, c) = 1;
            elseif theta >= 22.5 && theta < 67.5 
                sector(r, c) = 3;
            else
                sector(r, c) = 2;
            end
        end
    end
    imgTemp = zeros(m, n);
    for r = 2 : m - 1
        for c = 2 : n - 1
            switch sector(r, c)
                case 0
                    n1 = magGrad(r, c + 1);
                    n2 = magGrad(r, c - 1);
                case 1
                    n1 = magGrad(r - 1, c + 1);
                    n2 = magGrad(r + 1, c - 1);
                case 2
                    n1 = magGrad(r - 1, c);
                    n2 = magGrad(r + 1, c);
                case 3
                    n1 = magGrad(r + 1, c + 1);
                    n2 = magGrad(r - 1, c - 1);
            end
            if magGrad(r, c) < n1 || magGrad(r, c) < n2
                imgTemp(r, c) = 0;
            else
                if magGrad(r, c) >= highThresh
                    output(r, c) = 1;
                    imgTemp(r, c) = highThresh;
                elseif magGrad(r, c) >= lowThresh
                    imgTemp(r, c) = lowThresh;
                else
                    imgTemp(r, c) = 0;
                end
            end     
        end
    end
    
    for r = 2 : m - 1
        for c = 2 : n -1
            if imgTemp(r, c) == lowThresh
                cmpns = [imgTemp(r - 1, c - 1), imgTemp(r - 1, c), imgTemp(r - 1, c + 1), ...
                    imgTemp(r, c - 1), imgTemp(r, c + 1), ...
                    imgTemp(r + 1, c - 1), imgTemp(r + 1, c), imgTemp(r + 1, c + 1)]; 
                if ~isempty(find(cmpns) == highThresh)
                    output(r, c) = 1;
                end
            end
        end
    end
    output = logical(output);
    output = bwmorph(output, 'thin');
            
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
    % Select the threshold automatically
    cutoff = scale * sum(g(:), 'double') / numel(g);
    output = g > cutoff;
    output = bwmorph(output, 'thin');
end

