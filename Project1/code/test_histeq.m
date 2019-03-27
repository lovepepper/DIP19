%test histeq
I = imread('color1.png');
if numel(size(I)) == 3
    [J1] = Histogram_equalization(I, 1);
    [J2] = Histogram_equalization(I, 2);
    [J3] = Histogram_equalization(I, 3);
    figure
    subplot(2, 2, 1), imshow(I), title('ԭͼ��')
    subplot(2, 2, 2), imshow(J1), title('����һ')
    subplot(2, 2, 3), imshow(J2), title('������')
    subplot(2, 2, 4), imshow(J3), title('������')
else
    [J] = Histogram_equalization(I);
    figure
    subplot(1, 2, 1), imshow(I), title('ԭͼ��')
    subplot(1, 2, 2), imshow(J), title('���⻯')
end
