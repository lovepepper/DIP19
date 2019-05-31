function output = my_calculator(input_image)
%in this function, you should finish the character recognition task.
%the input parameter is a matrix of an image which contains several expressions
%the output parameter is a matrix of an image which contains the results of expressions 

table_rows = 10;
table_cols = 3;

in = rgb2gray(input_image);
ib = imbinarize(in);
[rows, cols] = size(ib);

% Remove the white border
output = cut(ib, 1, 1, rows, cols, 0);

[totalHeight, totalWidth] = size(output);
height = uint16(ceil(totalHeight / table_rows));
width = uint16(ceil(totalWidth / table_cols));

% Cut to get every grid and caculate
for i = 1 : table_rows
    for j = 1 : table_cols
        grid = cut(output, 1+height*(i-1), 1+width*(j-1), height*i, width*j, 1);
%         figure
%         imshow(grid);
        [gr, gc]  =size(grid);
        for m = 1 : gr - 1
            for n = 1:gc - 1
                gltr = 1+height*(i-1)+m;
                gltc = 1+width*(j-1)+n;
                if(output(gltr, gltc) == 1)
                    break;
                end
            end
            if(output(gltr, gltc) == 1)
                break;
            end
        end
        l = bwlabel(~grid);
        s = regionprops(l,'BoundingBox');
        LTc = floor(s(1).BoundingBox(1));
        LTr = floor(s(1).BoundingBox(2));
        lc = uint16(s(1).BoundingBox(3) + 1);
        lr = uint16(s(1).BoundingBox(4) + 1);
        digit1 = my_digit(grid(LTr:LTr+lr, LTc:LTc+lc));
        LTc = floor(s(2).BoundingBox(1));
        LTr = floor(s(2).BoundingBox(2));
        lc = uint16(s(2).BoundingBox(3) + 1);
        lr = uint16(s(2).BoundingBox(4) + 1);
        op = my_operator(grid(LTr:LTr+lr, LTc:LTc+lc));
        LTc = floor(s(3).BoundingBox(1));
        LTr = floor(s(3).BoundingBox(2));
        lc = uint16(s(3).BoundingBox(3) + 1);
        lr = uint16(s(3).BoundingBox(4) + 1);
        digit2 = my_digit(grid(LTr:LTr+lr, LTc:LTc+lc));
        digit1 = uint8(str2double(digit1));
        digit2 = uint8(str2double(digit2));
        if op == '+'
            res = digit1 + digit2;
        else 
            res = digit1 - digit2;
        end
        imgname = ['digit', num2str(res), '.jpg'];
        resimg = imread(imgname);
        resimg = imbinarize(rgb2gray(resimg));
        grid(3:82, 240:319) = resimg;
        output(gltr:gltr+gr-1, gltc:gltc+gc-1) = grid;
    end
end