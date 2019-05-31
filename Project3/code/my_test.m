%DIP19 Assignment 3
%Character Recongnition

clc; clear all;

% imgInput = imread('digit7.jpg');
% ib = imbinarize(rgb2gray(imgInput));
% digit = my_digit(ib);
% figure
% imshow(ib); 
% title(['识别结果: ', digit],'FontSize',20);

% imgInput = imread('op+.jpg');
% ib = imbinarize(rgb2gray(imgInput));
% op = my_operator(ib);
% figure
% imshow(ib); 
% title(['识别结果: ', op],'FontSize',20);

imname = 'test6.png';
imgInput = imread(imname);
imgOutput = my_calculator(imgInput);
imname = strsplit(imname, '.');
imname = ['E:/Workspace/DIP_Lab/Project3/asset/image/', imname{1,1}, '_result.png'];
imwrite(imgOutput, imname);

subplot(1, 2, 1);
imshow(imgInput);
subplot(1, 2, 2);
imshow(imgOutput);

