%DIP16 Assignment 2
%Edge Detection
%In this assignment, you should build your own edge detection and edge linking 
%function to detect the edges of a image.
%Please Note you cannot use the build-in matlab edge and bwtraceboundary function
%We supply four test images, and you can use others to show your results for edge
%detection, but you just need do edge linking for rubberband_cap.png.
clc; close all;

% Load the test image
% imgTest = im2double(imread('rubberband_cap.png'));
% imgTest = im2double(imread('bird.png'));
% imgTest = im2double(imread('giraffe.png'));
imgTest = im2double(imread('lenna.tiff'));
% imgTest = im2double(imread('dva.jpg'));
% imgTest = im2double(imread('moon.jpg'));
% imgTest = im2double(imread('logo.jpg'));
% imgTest = im2double(imread('noise.png'));
% imgTest = im2double(imread('noise2.png'));
imgTestGray = rgb2gray(imgTest);
figure; clf;
imshow(imgTest);

%now call your function my_edge, you can use matlab edge function to see
%the last result as a reference first
imgEdge1 = my_edge(imgTestGray, 'Roberts');
imgEdge2 = my_edge(imgTestGray, 'Prewitt'); 
imgEdge3 = my_edge(imgTestGray, 'Sobel'); 
imgEdge4 = my_edge(imgTestGray, 'Canny');
figure; clf;
imshow(imgEdge1);
title('Roberts Method');
figure; clf;
imshow(imgEdge2);
title('Prewitt Method');
figure; clf;
imshow(imgEdge3);
title('Sobel Method');
figure; clf;
imshow(imgEdge4);
title('Canny Method');

%using imtool, you select a object boundary to trace, and choose
%an appropriateedge point as the start point 

%imtool(imgEdge4);
edgePoints = [126, 232; 50, 92; 282, 227; 196, 79; 93, 296];

%now call your function my_edgelinking, you can use matlab bwtraceboundary 
%function to see the last result as a reference first. please trace as many 
%different object boundaries as you can, and choose different start edge points.
 
% figure;clf;
% background = imbinarize(imgTestGray, 1);
% imshow(background);
% 
% [rows, ~] = size(edgePoints);
% for i  = 1 : rows
%     Bxpc = my_edgelinking(imgEdge4, edgePoints(i, 1), edgePoints(i, 2));
%     hold on
%     plot(Bxpc(:,1), Bxpc(:,2), 'w', 'LineWidth', 1);
% end