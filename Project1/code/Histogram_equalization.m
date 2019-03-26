function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    r=input_image(:,:,1);
    v=input_image(:,:,2);
    b=input_image(:,:,3);
    r1 = hist_equal(r);
    v1 = hist_equal(v);
    b1 = hist_equal(b);
    output = cat(3,r1,v1,b1);    
else
    %this is a gray image
    [output] = hist_equal(input_image);
    
end

    function [output2] = hist_equal(input_channel)
    %you should complete this sub-function
    [row, col] = size(input_channel);
    H = imhist(input_channel);
    f = zeros(256, 1);
    for i = 1 : 256
        if(i == 1)
            f(i) = H(i);
        else
            f(i) = f(i - 1) + H(i);
        end
    end
    t = 255 * f / (row * col);
    output2 = zeros(row, col);
    for i = 1 : row
        for j = 1 : col
            output2(i, j) = round(t(input_channel(i, j) + 1));
        end
    end
    output2 = uint8(output2);
    end
end