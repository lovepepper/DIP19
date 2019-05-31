function digit = my_digit(ib)

%input: ib - a binary image
%output: digit - the digit in the image

%in this function, you should finish the digit recognition task.
%the input parameter is a matrix of an image which contains a digit.
%the output parameter represents which digit it is.

ib = ~ib;
results =ocr(ib,'TextLayout','Block');
digit = results.Text(1,1);