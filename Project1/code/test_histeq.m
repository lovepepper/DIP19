%test histeq
I = imread('color.jpg');
[J1] = Histogram_equalization(I, 1);
[J2] = Histogram_equalization(I, 2);
figure, imshow(I)
figure, imshow(J1)
figure, imshow(J2)
%figure, imshow(histeq(I))