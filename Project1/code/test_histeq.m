%test histeq
I = imread('color1.png');
if numel(size(I)) == 3
    [J1] = Histogram_equalization(I, 1);
    [J2] = Histogram_equalization(I, 2);
    [J3] = Histogram_equalization(I, 3);
    figure
    subplot(2, 2, 1), imshow(I), title('原图像')
    subplot(2, 2, 2), imshow(J1), title('方法一')
    subplot(2, 2, 3), imshow(J2), title('方法二')
    subplot(2, 2, 4), imshow(J3), title('方法三')
else
    [J] = Histogram_equalization(I);
    figure
    subplot(1, 2, 1), imshow(I), title('原图像')
    subplot(1, 2, 2), imshow(J), title('均衡化')
end
