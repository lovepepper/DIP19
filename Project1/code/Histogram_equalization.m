function [output] = Histogram_equalization(input_image, method)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    r=input_image(:,:,1);
    g=input_image(:,:,2);
    b=input_image(:,:,3);
    switch method
        case 1
            r1 = hist_equal(r);
            g1 = hist_equal(g);
            b1 = hist_equal(b);
            output = cat(3,r1,g1,b1);
        case 2
            [row2, col2] = size(r);
            Hr = imhist(r);
            Hg = imhist(g);
            Hb = imhist(b);
            H2 = round((Hr + Hg + Hb) / 3);
            f2 = zeros(256, 1);
            for i2 = 1 : 256
                if(i2 == 1)
                    f2(i2) = H2(i2);
                else
                    f2(i2) = f2(i2 - 1) + H2(i2);
                end
            end
            t2 = 255 * f2 / (row2 * col2);
            r2 = zeros(row2, col2);
            g2 = zeros(row2, col2);
            b2 = zeros(row2, col2);
            for i2 = 1 : row2
                for j2 = 1 : col2
                    r2(i2, j2) = round(t2(r(i2, j2) + 1));
                    g2(i2, j2) = round(t2(g(i2, j2) + 1));
                    b2(i2, j2) = round(t2(b(i2, j2) + 1));
                end
            end
            output = uint8(cat(3,r2,g2,b2));
    end
        
else
    %this is a gray image
    [output] = hist_equal(input_image);
    
end

    function [output2] = hist_equal(input)
    %you should complete this sub-function
    [row, col] = size(input);
    H = imhist(input);
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
            output2(i, j) = round(t(input(i, j) + 1));
        end
    end
    output2 = uint8(output2);
    end
end