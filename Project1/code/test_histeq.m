%test histeq
I = imread('color.jpg');
[J] = Histogram_equalization(I);
figure, imshow(I)
figure, imshow(J)
%figure, imshow(histeq(I))