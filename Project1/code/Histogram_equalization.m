function [output] = Histogram_equalization(input_image, varargin)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    r=input_image(:,:,1);
    g=input_image(:,:,2);
    b=input_image(:,:,3);
    switch varargin{1}
        case 1
            r1 = hist_equal(r);
            g1 = hist_equal(g);
            b1 = hist_equal(b);
            output = cat(3,r1,g1,b1);
        case 2
            Hr = imhist(r);
            Hg = imhist(g);
            Hb = imhist(b);
            H2 = round((Hr + Hg + Hb) / 3);
            r2 = hist_equal(r, H2);
            g2 = hist_equal(g, H2);
            b2 = hist_equal(b, H2);
            output = cat(3,r2,g2,b2);
        case 3
            hsvimg = rgb2hsv(input_image);
            v = hsvimg(:,:,3);
            v = uint8(v * 255);
            v = hist_equal(v);
            v = im2double(v);
            output = hsvimg;
            output(:,:,3) = v;
            output = hsv2rgb(output);
    end
        
else
    %this is a gray image
    [output] = hist_equal(input_image);
    
end

    function [output2] = hist_equal(input_channel, varargin)
    [row, col] = size(input_channel);
    if nargin == 1
        H = imhist(input_channel);
    elseif nargin == 2
        H = varargin{1};
    end
    sum = zeros(256, 1);
    for i = 1 : 256
        if(i == 1)
            sum(i) = H(i);
        else
            sum(i) = sum(i - 1) + H(i);
        end
    end
    F = 255 * sum / (row * col);
    output2 = zeros(row, col);
    for i = 1 : row
        for j = 1 : col
            output2(i, j) = round(F(input_channel(i, j) + 1));
        end
    end
    output2 = uint8(output2);
    end
end