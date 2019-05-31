function op = my_operator(ib)

%input: ib - a binary image
%output: op - the operator in the image

%in this function, you should finish the operator recognition task.
%the input parameter is a matrix of an image which contains an operator.
%the output parameter represents which operator it is. 
[r, c] = find(ib == 0);
[rectx,recty,area] = minboundrect(c,r,'a');
sumx = sum(rectx(1:4));
sumy = sum(recty(1:4));
centx = uint16(sumx / 4);
centy = uint16(sumy / 4);
if ib(centy, centx) == 1
    op = '=';
else
    if length(r) / double(area) > 0.9
        op = '-';
    else
        op = '+';
    end
end